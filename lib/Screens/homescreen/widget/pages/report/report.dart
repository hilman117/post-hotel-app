// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/controller_report.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/widget/column_four_rows.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/widget/custom_calendar.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/widget/data_table_widget.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/widget/histrory_screen.dart';
// import 'package:post_app/core.dart';
// import 'package:post_app/models/departement_model.dart';
// import 'package:post_app/models/popular_model.dart';
// import 'package:post_app/models/user_productivity_model.dart';
// import 'package:provider/provider.dart';

// import '../../../../../common_widget/loading.dart';
// import '../../../../../custom/custom_scroll_behavior.dart';
// import 'widget/chart_widget.dart';
// import 'widget/departement_box.dart';

// class Report extends StatelessWidget {
//   const Report({super.key, required this.listDept});

//   final List<Departement> listDept;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final eventReport = Provider.of<ControllerReport>(context, listen: false);
//     final eventAdmin = Provider.of<AdminController>(context, listen: false);
//     final eventHome = Provider.of<HomeController>(context, listen: false);
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//         eventHome.selectScreens(0);
//         return true;
//       },
//       child: GestureDetector(
//         onHorizontalDragEnd: (details) {
//           if (details.primaryVelocity! > 0) {
//             eventHome.selectScreens(0);
//             Get.back();
//           }
//         },
//         child: Scaffold(
//             // endDrawer: drawerWidet(context),
//             appBar: AppBar(
//               centerTitle: false,
//               elevation: theme.brightness == Brightness.dark ? 0 : 1,
//               // automaticallyImplyLeading: false,
//               leading: IconButton(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: fullWidth < maxWidth ? 20.sp : 20),
//                 onPressed: () => Get.back(),
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: theme.primaryColor,
//                 ),
//               ),
//               leadingWidth: fullWidth < maxWidth ? 30.sp : 30,
//               backgroundColor: theme.cardColor,
//               title: Text(
//                 "Report",
//                 style: TextStyle(
//                     color: theme.focusColor,
//                     fontSize: fullWidth < maxWidth ? 20.sp : 20),
//               ),
//               actions: [
//                 Tooltip(
//                   message: "Download report",
//                   child: IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.download_rounded,
//                         size: fullWidth < maxWidth ? 20.sp : 20,
//                         color: theme.primaryColor,
//                       )),
//                 ),
//                 IconButton(
//                     onPressed: () => customCalendar(context),
//                     icon: Icon(
//                       Icons.calendar_month,
//                       color: ThemeMode.system == ThemeMode.dark
//                           ? theme.focusColor
//                           : theme.primaryColor,
//                     ))
//                 // customCalendar(context)
//               ],
//             ),
//             backgroundColor: theme.scaffoldBackgroundColor,
//             body: Consumer3<ControllerReport, HomeController, AdminController>(
//               builder: (context, value, value2, value3, child) {
//                 List<Departement> list = value2.listDepartement
//                     .where((element) => element.isActive == true)
//                     .toList();
//                 List<UserProductivityModel> listData = value
//                     .userProductivityList
//                     .where(
//                         (element) => element.departement == value.selectedDept)
//                     .toList();
//                 List<PopularModel> listTitle = value.dataPopularTitle
//                     .where((element) => element.total != 0)
//                     .toList();
//                 String today = value.rangeStart != null
//                     ? DateFormat("dd").format(value.rangeStart!)
//                     : '';
//                 String now = DateFormat("dd")
//                     .format(DateTime.now().add(const Duration(days: 1)));
//                 String monthAgo = value.rangeEnd != null
//                     ? DateFormat("dd").format(
//                         value.rangeEnd!.subtract(const Duration(days: 30)))
//                     : "";
//                 String monthAgoNow = DateFormat("dd")
//                     .format(DateTime.now().subtract(const Duration(days: 30)));

//                 return ListView(
//                   children: [
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 10.h : 10,
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 120.h : 120,
//                       child: ScrollConfiguration(
//                         behavior:
//                             NoGlowScrollBehavior().copyWith(overscroll: false),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: list.length,
//                           itemBuilder: (context, index) {
//                             Departement dept = list[index];
//                             var tasks = value.listAllTasks
//                                 .where((element) =>
//                                     element.sendTo == dept.departement)
//                                 .toList();

//                             return departementBox(
//                                 context,
//                                 listDept,
//                                 dept.departementIcon!,
//                                 tasks.length,
//                                 dept.departement!);
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 10.h : 10,
//                     ),
//                     Row(
//                       children: [
//                         Card(
//                           color: Colors.transparent,
//                           elevation: ThemeMode.system == ThemeMode.dark ? 0 : 1,
//                           child: Container(
//                             color: theme.cardColor,
//                             alignment: Alignment.centerLeft,
//                             height: fullWidth < maxWidth ? 30.h : 30,
//                             padding: EdgeInsets.symmetric(horizontal: 10.sp),
//                             child: Text(
//                               "Period data :",
//                               style: TextStyle(
//                                   fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                                   color: theme.focusColor),
//                             ),
//                           ),
//                         ),
//                         Card(
//                           color: Colors.transparent,
//                           elevation:
//                               theme.brightness == Brightness.dark ? 0 : 1,
//                           child: Container(
//                             color: theme.cardColor,
//                             alignment: Alignment.centerLeft,
//                             height: fullWidth < maxWidth ? 30.h : 30,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "${value.rangeStart != null ? DateFormat("dd/MM/yy").format(value.rangeStart!) : ''} - ${value.rangeEnd != null ? DateFormat("dd/MM/yy").format(value.rangeEnd!) : ''}",
//                                   style: TextStyle(
//                                     fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                                     color: theme.focusColor,
//                                   ),
//                                 ),
//                                 if (today != now || monthAgoNow != monthAgo)
//                                   IconButton(
//                                       iconSize:
//                                           fullWidth < maxWidth ? 20.sp : 20,
//                                       padding: const EdgeInsets.all(0),
//                                       splashRadius:
//                                           fullWidth < maxWidth ? 15.r : 15,
//                                       onPressed: () async {
//                                         loading(context);
//                                         eventReport.clearDate();
//                                         await eventReport
//                                             .getPreviousMonthDates();
//                                         await eventReport
//                                             .calculateUserProductivity(
//                                                 value3.listEmployee);
//                                         await eventAdmin
//                                             .getEmployeeData(context);
//                                         await eventReport
//                                             .getMost10CreatorRequest(
//                                                 value3.listEmployee);
//                                         await eventReport
//                                             .getPopularTitle(listDept);
//                                         await eventReport.getPopularLocation(
//                                             value2.dataHotel!);
//                                         await eventReport.getTopReceiver(
//                                             value3.listEmployee);
//                                         eventReport.getChartSeries(listDept);
//                                         Navigator.of(context).pop();
//                                       },
//                                       icon: Icon(
//                                         Icons.close,
//                                         color: Colors.blue,
//                                         size: fullWidth < maxWidth ? 20.sp : 20,
//                                       ))
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Card(
//                           elevation: ThemeMode.system == ThemeMode.dark ? 0 : 1,
//                           color: Colors.transparent,
//                           child: Container(
//                             color: theme.cardColor,
//                             alignment: Alignment.centerLeft,
//                             height: fullWidth < maxWidth ? 30.h : 30,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                             child: Text(
//                               "Filter by :",
//                               style: TextStyle(
//                                   fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                                   color: theme.focusColor),
//                             ),
//                           ),
//                         ),
//                         Card(
//                           color: Colors.transparent,
//                           elevation:
//                               theme.brightness == Brightness.dark ? 0 : 1,
//                           child: Container(
//                             color: theme.cardColor,
//                             alignment: Alignment.center,
//                             height: fullWidth < maxWidth ? 30.h : 30,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   value.selectedDept != ""
//                                       ? value.selectedDept
//                                       : "All",
//                                   style: TextStyle(
//                                       fontSize:
//                                           fullWidth < maxWidth ? 14.sp : 14,
//                                       color: theme.focusColor),
//                                 ),
//                                 if (value.selectedDept.isNotEmpty)
//                                   IconButton(
//                                       iconSize:
//                                           fullWidth < maxWidth ? 20.sp : 20,
//                                       padding: const EdgeInsets.all(0),
//                                       splashRadius:
//                                           fullWidth < maxWidth ? 15.r : 15,
//                                       onPressed: () async {
//                                         loading(context);
//                                         eventReport.clearFilterDepartement();
//                                         await eventReport
//                                             .calculateUserProductivity(
//                                                 value3.listEmployee);
//                                         await eventAdmin
//                                             .getEmployeeData(context);
//                                         await eventReport
//                                             .getMost10CreatorRequest(
//                                                 value3.listEmployee);
//                                         await eventReport
//                                             .getPopularTitle(listDept);
//                                         await eventReport.getPopularLocation(
//                                             value2.dataHotel!);
//                                         await eventReport.getTopReceiver(
//                                             value3.listEmployee);
//                                         eventReport.getChartSeries(listDept);
//                                         Navigator.of(context).pop();
//                                       },
//                                       icon: Icon(
//                                         Icons.close,
//                                         color: Colors.blue,
//                                         size: fullWidth < maxWidth ? 20.sp : 20,
//                                       ))
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 10.h : 10,
//                     ),
//                     Card(
//                       color: Colors.transparent,
//                       elevation: theme.brightness == Brightness.dark ? 0 : 1,
//                       margin: EdgeInsets.symmetric(
//                           horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                       child: ListTile(
//                         tileColor: theme.cardColor,
//                         onTap: () async {
//                           List<TaskModel> listAllDept = value.listAllTasks
//                               .where((element) => element.status == "Close")
//                               .toList();
//                           Get.to(
//                               () => HistoryScreen(
//                                     list: listAllDept,
//                                   ),
//                               transition: Transition.rightToLeft);
//                           eventReport.cleaner();
//                         },
//                         title: Text(
//                           value.historyTask,
//                           style: TextStyle(
//                               fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                               color: theme.focusColor),
//                         ),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios,
//                           color: theme.focusColor,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 10.h : 10,
//                     ),
//                     ScrollConfiguration(
//                         behavior:
//                             NoGlowScrollBehavior().copyWith(overscroll: false),
//                         child: ChartWidget(
//                           listDept: list,
//                         )),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 10.h : 10,
//                     ),
//                     AnimatedContainer(
//                       duration: const Duration(
//                         milliseconds: 500,
//                       ),
//                       child: value.selectedDept != ""
//                           ? DataTableWidget(
//                               theme: theme,
//                               label: "User Productivity",
//                               labelColumn: value.labelColumn1,
//                               listDataRows:
//                                   List.generate(listData.length, (index) {
//                                 UserProductivityModel data = listData[index];
//                                 return DataRow(
//                                   selected:
//                                       value.selectedRow == index ? true : false,
//                                   onSelectChanged: (value) =>
//                                       eventReport.selectingRowData(index),
//                                   cells: [
//                                     DataCell(
//                                       Text(
//                                         data.userName ?? '',
//                                         style: TextStyle(
//                                           fontSize:
//                                               fullWidth < maxWidth ? 16.sp : 16,
//                                           fontWeight: FontWeight.normal,
//                                           color:
//                                               theme.focusColor.withOpacity(0.5),
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           data.totalCreate.toString(),
//                                           style: TextStyle(
//                                             fontSize: fullWidth < maxWidth
//                                                 ? 16.sp
//                                                 : 16,
//                                             fontWeight: FontWeight.normal,
//                                             color: theme.focusColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           data.totalReceive.toString(),
//                                           style: TextStyle(
//                                             fontSize: fullWidth < maxWidth
//                                                 ? 16.sp
//                                                 : 16,
//                                             fontWeight: FontWeight.normal,
//                                             color: theme.focusColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }),
//                             )
//                           : DataTableWidget(
//                               theme: theme,
//                               label: "Request Departement",
//                               labelColumn: value.labelColumn2,
//                               listDataRows:
//                                   List.generate(listTitle.length, (index) {
//                                 listTitle.sort(
//                                     (a, b) => b.total!.compareTo(a.total!));
//                                 PopularModel data = listTitle[index];
//                                 return DataRow(
//                                   selected:
//                                       value.selectedRow == index ? true : false,
//                                   onSelectChanged: (value) =>
//                                       eventReport.selectingRowData(index),
//                                   cells: [
//                                     DataCell(
//                                       Text(
//                                         data.itemName ?? '',
//                                         style: TextStyle(
//                                           fontSize:
//                                               fullWidth < maxWidth ? 16.sp : 16,
//                                           fontWeight: FontWeight.normal,
//                                           color:
//                                               theme.focusColor.withOpacity(0.5),
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           data.total.toString(),
//                                           style: TextStyle(
//                                             fontSize: fullWidth < maxWidth
//                                                 ? 16.sp
//                                                 : 16,
//                                             fontWeight: FontWeight.normal,
//                                             color: theme.focusColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }),
//                             ),
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 20.h : 20,
//                     ),
//                     ColumnFourRows(
//                       theme: theme,
//                       data: value.dataPopularLocation,
//                       label: value.labelColumn3,
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 20.h : 20,
//                     ),
//                     ColumnFourRows(
//                       theme: theme,
//                       data: value.dataPopularTitle,
//                       label: value.labelColumn4,
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 20.h : 20,
//                     ),
//                     DataTableWidget(
//                       theme: theme,
//                       label: "Top 10 Receivers",
//                       labelColumn: value.labelColumn5,
//                       listDataRows:
//                           List.generate(value.dataTopReceiver.length, (index) {
//                         value.dataTopReceiver
//                             .sort((a, b) => b.total!.compareTo(a.total!));
//                         PopularModel data = value.dataTopReceiver[index];
//                         return DataRow(
//                           selected: value.selectedRow == index ? true : false,
//                           onSelectChanged: (value) =>
//                               eventReport.selectingRowData(index),
//                           cells: [
//                             DataCell(
//                               Text(
//                                 data.itemName ?? '',
//                                 style: TextStyle(
//                                   fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                                   fontWeight: FontWeight.normal,
//                                   color: theme.focusColor.withOpacity(0.5),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   data.departement.toString(),
//                                   style: TextStyle(
//                                     fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                                     fontWeight: FontWeight.normal,
//                                     color: theme.focusColor.withOpacity(0.5),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             DataCell(
//                               Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   data.departement.toString(),
//                                   style: TextStyle(
//                                     fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                                     fontWeight: FontWeight.normal,
//                                     color: theme.focusColor.withOpacity(0.5),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 20.h : 20,
//                     ),
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 500),
//                       child: value.selectedDept != ""
//                           ? const SizedBox()
//                           : DataTableWidget(
//                               theme: theme,
//                               label: "Top 10 Creators",
//                               labelColumn: value.labelColumn5,
//                               listDataRows: List.generate(
//                                   value.listTopCreator.length, (index) {
//                                 value.listTopCreator.sort(
//                                     (a, b) => b["total"].compareTo(a["total"]));
//                                 var data = value.listTopCreator[index];
//                                 return DataRow(
//                                   selected:
//                                       value.selectedRow == index ? true : false,
//                                   onSelectChanged: (value) =>
//                                       eventReport.selectingRowData(index),
//                                   cells: [
//                                     DataCell(
//                                       Text(
//                                         data["name"] ?? '',
//                                         style: TextStyle(
//                                           fontSize:
//                                               fullWidth < maxWidth ? 16.sp : 16,
//                                           fontWeight: FontWeight.normal,
//                                           color:
//                                               theme.focusColor.withOpacity(0.5),
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           data["department"].toString(),
//                                           style: TextStyle(
//                                             fontSize: fullWidth < maxWidth
//                                                 ? 16.sp
//                                                 : 16,
//                                             fontWeight: FontWeight.normal,
//                                             color: theme.focusColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     DataCell(
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           data["total"].toString(),
//                                           style: TextStyle(
//                                             fontSize: fullWidth < maxWidth
//                                                 ? 16.sp
//                                                 : 16,
//                                             fontWeight: FontWeight.normal,
//                                             color: theme.focusColor
//                                                 .withOpacity(0.5),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               }),
//                             ),
//                     )
//                   ],
//                 );
//               },
//             )),
//       ),
//     );
//   }
// }
