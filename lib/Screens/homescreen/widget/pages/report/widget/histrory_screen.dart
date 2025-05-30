// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/widget/card_request.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/controller_report.dart';
// import 'package:provider/provider.dart';

// import '../../../../../../models/tasks.dart';
// import '../../../../home_controller.dart';

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key, required this.list});
//   final List<TaskModel> list;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: fabHistory(context),
//         appBar: AppBar(
//           leadingWidth: 30.sp,
//           leading: InkWell(
//             borderRadius: BorderRadius.circular(50.r),
//             onTap: () => Get.back(),
//             child: Padding(
//               padding: EdgeInsets.only(left: 15.sp),
//               child: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 25.sp,
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     color: theme.focusColor,
//                   )),
//             ),
//           ),
//           backgroundColor: theme.scaffoldBackgroundColor,
//           title: Text(
//             "History Tasks",
//             style: TextStyle(color: theme.focusColor),
//           ),
//         ),
//         body: Consumer2<HomeController, ControllerReport>(
//             builder: (context, value, value2, child) {
//           list.sort(
//             (a, b) => b.time!.compareTo(a.time!),
//           );
//           List<TaskModel> listByDept = value2.selectedDept == ""
//               ? list
//               : list
//                   .where((element) => element.sendTo == value2.selectedDept)
//                   .toList();
//           return ListView.builder(
//             itemCount: listByDept.length,
//             itemBuilder: (context, index) {
//               TaskModel task = listByDept[index];
//               if (task.sender!
//                       .toLowerCase()
//                       .contains(value2.keyWords.toLowerCase()) ||
//                   task.description!
//                       .toLowerCase()
//                       .contains(value2.keyWords.toLowerCase()) ||
//                   task.receiver!
//                       .toLowerCase()
//                       .contains(value2.keyWords.toLowerCase()) ||
//                   task.title!
//                       .toLowerCase()
//                       .contains(value2.keyWords.toLowerCase()) ||
//                   task.location!
//                       .toLowerCase()
//                       .contains(value2.keyWords.toLowerCase()) ||
//                   value2.keyWords.isEmpty) {
//                 return CardRequest(
//                   data: task,
//                   animationColor: theme.cardColor,
//                   listImage: task.image!,
//                   listRequest: listByDept,
//                 );
//               }
//               return SizedBox();
//             },
//           );
//         }));
//   }
// }

// Widget fabHistory(BuildContext context) {
//   final theme = Theme.of(context);
//   final event = Provider.of<ControllerReport>(context, listen: false);
//   return Consumer<ControllerReport>(
//       builder: (context, value, child) => AnimatedContainer(
//             margin: EdgeInsets.all(10.sp),
//             height: 40.h,
//             duration: Duration(milliseconds: 500),
//             decoration: BoxDecoration(color: theme.cardColor),
//             child: TextFormField(
//               onChanged: (value) => event.searchTask(value),
//               controller: value.searchTasksHistoty,
//               decoration: InputDecoration(
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.transparent)),
//                   prefixIcon: Icon(Icons.search, color: theme.splashColor),
//                   hintText: "Search",
//                   hintStyle: TextStyle(color: theme.splashColor)),
//             ),
//           ));
// }
