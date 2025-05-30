// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:post_app/fireabase_service/firebase_read_data.dart';
// import 'package:post_app/models/hotel_data_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../../../../../models/chart_data_model.dart';
// import '../../../../../models/departement_model.dart';
// import '../../../../../models/popular_model.dart';
// import '../../../../../models/tasks.dart';
// import '../../../../../models/user.dart';
// import '../../../../../models/user_productivity_model.dart';

// class ControllerReport with ChangeNotifier {
//   final read = FirebaseReadData();

//   //new daterange picker
//   Future<void> selectDateRange(BuildContext context) async {
//     final initialDateRange = DateTimeRange(
//       start: rangeStart ?? DateTime.now(),
//       end: rangeEnd ?? DateTime.now().add(Duration(days: 7)),
//     );

//     final pickedDateRange = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2021),
//       lastDate: DateTime(2024),
//       initialDateRange: initialDateRange,
//     );

//     if (pickedDateRange != null) {
//       rangeStart = pickedDateRange.start;
//       rangeEnd = pickedDateRange.end;
//     }
//     notifyListeners();
//   }

//   TextEditingController searchTasksHistoty = TextEditingController();
//   String keyWords = "";
//   void searchTask(String value) {
//     keyWords = value;
//     notifyListeners();
//   }

//   void cleaner() {
//     searchTasksHistoty.clear();
//     keyWords = "";
//     notifyListeners();
//   }

//   String historyTask = "History All Tasks";
//   String selectedDept = "";
//   void selectReportByDept(String dept, List<UserDetails> userDetailsList) {
//     selectedDept = dept;
//     historyTask = "History $selectedDept Tasks";
//     selectedRow = -1;
//     notifyListeners();
//   }

//   void clearFilterDepartement() {
//     selectedDept = "";
//     historyTask = "History All Tasks";
//     getPreviousMonthDates();
//   }

//   void clearDate() {
//     rangeStart = DateTime.now().subtract(const Duration(days: 30));
//     rangeEnd = DateTime.now();
//     notifyListeners();
//   }

//   //get all tasks data
//   List<TaskModel> listAllTasks = [];
//   Future<void> getAllTaskData(BuildContext context) async {
//     listAllTasks.clear();
//     try {
//       listAllTasks = await read.getCloseTask().then((value) =>
//           value.docs.map((e) => TaskModel.fromJson(e.data())).toList());

//       Navigator.of(context).pop();
//     } catch (e) {
//       print(e);
//     }
//     notifyListeners();
//   }

//   //ALL ABOUT CALENDAR
//   CalendarFormat calendarFormat = CalendarFormat.month;
//   DateTime focusedDay = DateTime.now();
//   DateTime? selectedDay = DateTime.now();
//   RangeSelectionMode rangeSelectionMode = RangeSelectionMode
//       .toggledOn; // Can be toggled on/off by longpressing a date
//   DateTime? rangeStart = DateTime.now().subtract(const Duration(days: 30));
//   DateTime? rangeEnd = DateTime.now();

//   onDaySelected(DateTime day, DateTime today) {
//     selectedDay = day;
//     focusedDay = today;
//     rangeSelectionMode = RangeSelectionMode.toggledOff;
//     rangeStart = null;
//     rangeEnd = null;
//     notifyListeners();
//   }

//   onRangeSelected(DateTime today, DateTime? startRange, DateTime? endRange) {
//     focusedDay = today;
//     rangeStart = startRange;
//     rangeEnd = endRange;
//     rangeSelectionMode = RangeSelectionMode.toggledOn;
//     notifyListeners();
//     // ignore: avoid_print
//     // print(rangeStart);
//     // ignore: avoid_print
//     // print(rangeEnd);
//   }

//   onFormatChanged(CalendarFormat format) {
//     calendarFormat = format;
//     notifyListeners();
//   }

//   onPageChanged(DateTime today) {
//     focusedDay = today;
//     notifyListeners();
//   }

//   // //METHOD UNTUK MENGAMBIL DATA DAILY CHART
//   List<DateTime> listDate = [];

//   Future<List<DateTime>> getPreviousMonthDates() async {
//     listDate.clear();
//     // Mendapatkan tanggal saat ini
//     DateTime? currentDate = rangeStart;
//     while (currentDate!.isBefore(rangeEnd!) ||
//         currentDate.isAtSameMomentAs(rangeEnd!)) {
//       listDate.add(currentDate);
//       currentDate = currentDate.add(const Duration(days: 1));
//     }
//     notifyListeners();
//     return listDate;
//   }

//   List<ChartData> chartDataList = [];
//   List<StackedColumnSeries<ChartData, String>> series = [];
//   List<StackedColumnSeries<ChartData, String>> getChartSeries(
//       List<Departement> listDept) {
//     series.clear();
//     chartDataList.clear();
//     for (Departement department in listDept) {
//       for (DateTime date in listDate) {
//         int count = 0;
//         String fromListDate = DateFormat('dd/MM/yy').format(date);
//         // Count the occurrences of the department on the specific date
//         for (TaskModel task in listAllTasks) {
//           String formattedDate = DateFormat('dd/MM/yy').format(task.time!);
//           if (formattedDate == fromListDate &&
//               task.sendTo == department.departement) {
//             count++;
//           }
//         }

//         // Create chart data entries
//         chartDataList
//             .add(ChartData(department.departement!, fromListDate, count));
//       }
//     }

//     if (selectedDept.isNotEmpty) {
//       // Filter chart data by selected department
//       chartDataList = chartDataList
//           .where((data) => data.department == selectedDept)
//           .toList();
//     }

//     // Group the chart data by department
//     Map<String, List<ChartData>> groupedData = {};
//     for (ChartData data in chartDataList) {
//       if (!groupedData.containsKey(data.department)) {
//         groupedData[data.department] = [];
//       }
//       groupedData[data.department]!.add(data);
//     }

//     // Create chart series for each department
//     groupedData.forEach((department, data) {
//       series.add(
//         StackedColumnSeries<ChartData, String>(
//           animationDuration: 700,
//           dataSource: data,
//           xValueMapper: (ChartData entry, _) => entry.category,
//           yValueMapper: (ChartData entry, _) => entry.value,
//           name: department,
//           dataLabelSettings: DataLabelSettings(
//             isVisible: false,
//           ),
//         ),
//       );
//     });
//     notifyListeners();
//     return series;
//   }

//   //METHOD UNTUK ME-FILTER 10 USER TERBANYAK MEMBUAT REQUEST DLM 1 BULAN.
//   List<Map<String, dynamic>> listTopCreator = [];
//   Future getMost10CreatorRequest(List<UserDetails> employeeList) async {
//     listTopCreator.clear();
//     for (var employee in employeeList) {
//       var resultData = listAllTasks.where((request) {
//         DateTime timeStart = request.time!.subtract(Duration(days: 1));
//         DateTime timeEnd = request.time!.add(Duration(days: 1));
//         return request.sender == employee.name &&
//             rangeStart!.isBefore(timeEnd) &&
//             rangeEnd!.isAfter(timeStart);
//       }).toList();
//       if (resultData.isNotEmpty) {
//         for (var taskmodel in resultData) {
//           if (listTopCreator
//               .every((element) => element['name'] != taskmodel.sender)) {
//             listTopCreator.add({
//               "name": taskmodel.sender,
//               "total": resultData.length,
//               "department": taskmodel
//                   .from, // Ubah disini, ganti dengan properti yang sesuai
//             });
//           }
//         }
//       }
//     }
//     notifyListeners();
//   }

//   //method popular title
//   List<PopularModel> dataPopularTitle = [];
//   Map<String, int> titleCount = {};
//   Set<String> titleSet = {};

//   Future getPopularTitle(List<Departement> listDept) async {
//     dataPopularTitle.clear();
//     titleCount.clear();
//     titleSet.clear();
//     await Future.delayed(const Duration(milliseconds: 500), () {
//       for (var i = 0; i < listDept.length; i++) {
//         var titleDept = listDept[i].title;
//         if (titleDept!.isNotEmpty) {
//           titleSet.addAll(titleDept);
//         }
//       }
//     });

//     var resultData = listAllTasks.where((request) {
//       DateTime timeStart = request.time!.subtract(Duration(days: 1));
//       DateTime timeEnd = request.time!.add(Duration(days: 1));
//       return rangeStart!.isBefore(timeEnd) && rangeEnd!.isAfter(timeStart);
//     }).toList();

//     for (String title in titleSet) {
//       if (selectedDept.isNotEmpty) {
//         // Cek apakah judul cocok dengan selectedDept
//         bool isMatch = false;
//         for (Departement dept in listDept) {
//           if (dept.departement == selectedDept && dept.title!.contains(title)) {
//             isMatch = true;
//             break;
//           }
//         }
//         if (!isMatch) {
//           continue; // Lewati judul jika tidak cocok dengan selectedDept
//         }
//       }

//       int count = 0;
//       int closedCount = 0;
//       double donePercent = 0;
//       String resTime = "";

//       for (TaskModel req in resultData) {
//         if (req.title == title) {
//           count++;

//           if (req.status == 'Close') {
//             closedCount++;
//           }
//         }
//       }

//       if (count > 0) {
//         donePercent = (closedCount / count) * 100;
//       }
//       dataPopularTitle.add(PopularModel(
//           itemName: title,
//           total: count,
//           closed: closedCount,
//           ratePercent: "${donePercent.toStringAsFixed(0)}%",
//           resolutionTime: resTime));
//     }
//     notifyListeners();
//   }

//   //method popular location
//   List<PopularModel> dataPopularLocation = [];
//   // create a Map to keep track of the location count
//   // Map<String, int> locationCount = {};
//   // List<String> titleList = [];

//   Future getPopularLocation(HotelDataModel dataHotel) async {
//     dataPopularLocation.clear();
//     var locationList = dataHotel.location!;
//     // loop through the requests to count the title occurrences
//     var resultData = listAllTasks.where((request) {
//       DateTime timeStart = request.time!.subtract(Duration(days: 1));
//       DateTime timeEnd = request.time!.add(Duration(days: 1));
//       return rangeStart!.isBefore(timeEnd) && rangeEnd!.isAfter(timeStart);
//     }).toList();
//     for (String location in locationList) {
//       int count = 0;
//       int closedCount = 0;
//       double donePercent = 0;
//       String resTime = "";

//       for (TaskModel req in resultData) {
//         if (req.location == location) {
//           count++;

//           if (req.status == 'Close') {
//             closedCount++;
//           }
//         }
//       }

//       if (count > 0) {
//         donePercent = (closedCount / count) * 100;
//       }
//       dataPopularLocation.add(PopularModel(
//           itemName: location,
//           total: count,
//           closed: closedCount,
//           ratePercent: "${donePercent.toStringAsFixed(0)}%",
//           resolutionTime: resTime));
//     }
//     notifyListeners();
//   }

//   List<PopularModel> dataTopReceiver = [];
//   // create a Map to keep track of the location count
//   // Map<String, int> locationCount = {};
//   List<String> listName = [];

//   Future getTopReceiver(List<UserDetails> employeeData) async {
//     dataTopReceiver.clear();
//     listName.clear();
//     await Future.delayed(
//       const Duration(milliseconds: 500),
//       () {
//         for (var i = 0; i < employeeData.length; i++) {
//           listName.add(employeeData[i].name!);
//         }
//       },
//     );
//     var resultData = listAllTasks.where((request) {
//       DateTime timeStart = request.time!.subtract(Duration(days: 1));
//       DateTime timeEnd = request.time!.add(Duration(days: 1));
//       return rangeStart!.isBefore(timeEnd) && rangeEnd!.isAfter(timeStart);
//     }).toList();

//     for (String name in listName) {
//       int count = 0;
//       int closedCount = 0;
//       double donePercent = 0;
//       String resTime = "";

//       for (TaskModel req in resultData) {
//         if (req.receiver == name) {
//           count++;

//           if (req.status == 'Close') {
//             closedCount++;
//           }
//         }
//       }

//       if (count > 0) {
//         donePercent = (closedCount / count) * 100;
//       }
//       dataTopReceiver.add(PopularModel(
//           itemName: name,
//           total: count,
//           closed: closedCount,
//           ratePercent: "${donePercent.toStringAsFixed(0)}%",
//           resolutionTime: resTime));
//     }
//     notifyListeners();
//   }

//   List<UserProductivityModel> userProductivityList = [];
//   Future<List<UserProductivityModel>> calculateUserProductivity(
//     List<UserDetails> userDetailsList,
//   ) async {
//     userProductivityList.clear();
//     // Filter requestList based on the date range and selectedDept
//     List<TaskModel> filteredByRangeDate = listAllTasks.where((task) {
//       DateTime taskDate = task.time!;
//       DateTime start = rangeStart!.subtract(Duration(days: 1));
//       DateTime ends = rangeEnd!.add(Duration(days: 1));
//       return taskDate.isAfter(start) && taskDate.isBefore(ends);
//     }).toList();
//     // Calculate user productivity for each department
//     for (UserDetails user in userDetailsList) {
//       int totalCreate = 0;
//       int totalReceive = 0;

//       // Calculate total created requests
//       totalCreate =
//           filteredByRangeDate.where((task) => task.sender == user.name).length;

//       // Calculate total received requests
//       totalReceive = filteredByRangeDate
//           .where((task) => task.receiver == user.name)
//           .length;
//       // Create UserProductivityModel object and add it to the list
//       UserProductivityModel userProductivity = UserProductivityModel(
//         userName: user.name,
//         totalCreate: totalCreate,
//         totalReceive: totalReceive,
//         departement: user.department,
//       );
//       userProductivityList.add(userProductivity);
//       notifyListeners();
//     }
//     print(userProductivityList);
//     return userProductivityList;
//   }

//   List<String> labelColumn1 = ["User name", "Create", "Receive"];
//   List<String> labelColumn2 = ["Title", "Jumlah"];
//   List<String> labelColumn3 = [
//     "Location",
//     "Jumlah",
//     "Close",
//     "Rate Resolution",
//     "Percent"
//   ];
//   List<String> labelColumn4 = [
//     "Title",
//     "Jumlah",
//     "Close",
//     "Rate Resolution",
//     "Percent"
//   ];
//   List<String> labelColumn5 = [
//     "User Name",
//     "Departement",
//     "Jumlah",
//   ];
//   //untuk remark data by tapping
//   int selectedRow = -1;
//   void selectingRowData(int value) {
//     selectedRow = value;
//     notifyListeners();
//   }
// }
