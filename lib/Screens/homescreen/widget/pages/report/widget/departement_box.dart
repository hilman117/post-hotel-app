// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:provider/provider.dart';

// import '../../../../../../common_widget/loading.dart';
// import '../../../../../../models/departement_model.dart';
// import '../controller_report.dart';

// Widget departementBox(BuildContext context, List<Departement> listDept,
//     String iconDept, int totalRequest, String deptName) {
//   final theme = Theme.of(context);
//   final eventReport = Provider.of<ControllerReport>(context, listen: false);
//   final eventAdmin = Provider.of<AdminController>(context, listen: false);
//   double fullWidth = MediaQuery.of(context).size.width;
//   double maxWidth = 500;
//   return Container(
//       width: fullWidth < maxWidth ? 230.w : 230,
//       margin: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//       child: Consumer3<ControllerReport, AdminController, HomeController>(
//         builder: (context, value, value2, value3, child) => Card(
//           color: Colors.transparent,
//           elevation: theme.brightness == Brightness.dark ? 0 : 2,
//           shape: RoundedRectangleBorder(
//               borderRadius:
//                   BorderRadius.circular(fullWidth < maxWidth ? 20.sp : 20)),
//           child: ListTile(
//             tileColor: value.selectedDept == deptName
//                 ? Colors.grey.withOpacity(0.3)
//                 : theme.cardColor,
//             shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.circular(fullWidth < maxWidth ? 20.sp : 20)),
//             onTap: () async {
//               loading(context);
//               eventReport.selectReportByDept(deptName, value2.listEmployee);
//               await eventReport.getAllTaskData(context);
//               await eventReport.calculateUserProductivity(value2.listEmployee);
//               await eventAdmin.getEmployeeData(context);
//               await eventReport.getMost10CreatorRequest(value2.listEmployee);
//               await eventReport.getPopularTitle(listDept);
//               await eventReport.getPopularLocation(value3.dataHotel!);
//               await eventReport.getTopReceiver(value2.listEmployee);
//               eventReport.getChartSeries(listDept);
//             },
//             title: Row(
//               children: [
//                 Image.asset(
//                   iconDept,
//                   width: fullWidth < maxWidth ? 40.w : 40,
//                   height: fullWidth < maxWidth ? 40.h : 40,
//                 ),
//                 SizedBox(
//                   width: fullWidth < maxWidth ? 10.w : 10,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       totalRequest.toString(),
//                       style: TextStyle(
//                           fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                           color: theme.focusColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: fullWidth < maxWidth ? 5.h : 5,
//                     ),
//                     SizedBox(
//                         width: fullWidth < maxWidth ? 120.w : 120,
//                         child: Text(
//                           deptName,
//                           style: TextStyle(
//                               fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                               fontWeight: FontWeight.bold,
//                               color: theme.focusColor),
//                         )),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ));
// }
