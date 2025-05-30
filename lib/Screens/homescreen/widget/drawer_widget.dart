// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/change_password/change_password.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/lost_and_found/lost_and_found.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/lost_and_found/lost_and_found_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/controller_report.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/report/report.dart';
// import 'package:post_app/Screens/settings/widget/log_out_dialog.dart';
// import 'package:post_app/common_widget/loading.dart';
// import 'package:post_app/common_widget/photo_profile.dart';
// import 'package:post_app/controller/c_user.dart';
// import 'package:provider/provider.dart';

// Widget drawerWidet(BuildContext context) {
//   final theme = Theme.of(context);
//   final user = Get.put(CUser());
//   final event = Provider.of<HomeController>(context, listen: false);
//   final eventReport = Provider.of<ControllerReport>(context, listen: false);
//   final eventAdmin = Provider.of<AdminController>(context, listen: false);
//   final eventLf =
//       Provider.of<LostAndFoundControntroller>(context, listen: false);
//   double fullWidth = MediaQuery.of(context).size.width;
//   double maxWidth = 500;
//   return Container(
//     width: fullWidth < maxWidth ? 250.w : 300,
//     color: theme.scaffoldBackgroundColor,
//     child: Column(
//       children: [
//         SizedBox(
//             height: fullWidth < maxWidth ? 150.h : 250,
//             child: Consumer<HomeController>(
//               builder: (context, value, child) => PhotoProfile(
//                   lebar: fullWidth < maxWidth ? 250.w : 250,
//                   tinggi: fullWidth < maxWidth ? 150.h : 250,
//                   radius: 0,
//                   urlImage: value.imageHOtel!),
//             )),
//         SizedBox(
//           height: fullWidth < maxWidth ? 10.h : 10,
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: fullWidth < maxWidth ? 10.sp : 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   user.data.name!,
//                   style: TextStyle(
//                       color: theme.focusColor,
//                       fontSize: fullWidth < maxWidth ? 14.sp : 14),
//                 ),
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 5.h : 5,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   user.data.email!,
//                   style: TextStyle(
//                       color: theme.focusColor,
//                       fontSize: fullWidth < maxWidth ? 14.sp : 14),
//                 ),
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 5.h : 5,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   user.data.department!,
//                   style: TextStyle(
//                       color: theme.focusColor,
//                       fontSize: fullWidth < maxWidth ? 14.sp : 14),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: fullWidth < maxWidth ? 15.h : 15,
//         ),
//         Consumer2<HomeController, AdminController>(
//             builder: (context, value, value2, child) => Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                 width: fullWidth < maxWidth ? 250.w : 250,
//                 child: Column(
//                   children: List.generate(6, (index) {
//                     Pages pages = value.pages[index];
//                     if (user.data.accountType != "Dept. Admin" && index == 2) {
//                       return const SizedBox();
//                     } else if (user.data.accountType != "Administrator" &&
//                         index == 1) {
//                       return const SizedBox();
//                     }
//                     return InkWell(
//                       onTap: () async {
//                         event.selectScreens(index);
//                         switch (index) {
//                           case 1:
//                             Get.to(
//                                 () => const Admin(
//                                       screen: 0,
//                                     ),
//                                 transition: Transition.rightToLeft);
//                             break;
//                           case 2:
//                             loading(context);
//                             var listDepartement = value.listDepartement
//                                 .where((element) => element.isActive == true)
//                                 .toList();
//                             eventReport.clearDate();
//                             eventReport.clearFilterDepartement();
//                             await eventReport.getAllTaskData(context);
//                             await eventReport.getPreviousMonthDates();
//                             await eventReport
//                                 .calculateUserProductivity(value2.listEmployee);
//                             await eventAdmin.getEmployeeData(context);
//                             await eventReport
//                                 .getMost10CreatorRequest(value2.listEmployee);
//                             await eventReport.getPopularTitle(listDepartement);
//                             await eventReport
//                                 .getPopularLocation(value.dataHotel!);
//                             await eventReport
//                                 .getTopReceiver(value2.listEmployee);
//                             eventReport.getChartSeries(listDepartement);
//                             Navigator.of(context).pop();
//                             Get.to(
//                                 () => Report(
//                                       listDept: listDepartement,
//                                     ),
//                                 transition: Transition.rightToLeft);

//                             break;
//                           case 3:
//                             //
//                             eventLf.readLostAndFound(context);
//                             break;
//                           case 4:
//                             Get.to(() => const ChangePassword(),
//                                 transition: Transition.rightToLeft);

//                             break;
//                           case 5:
//                             logoutDialog(context);
//                             break;
//                         }
//                       },
//                       child: Container(
//                         color: value.indexScreen == index
//                             ? theme.cardColor
//                             : Colors.transparent,
//                         height: fullWidth < maxWidth ? 40.h : 40,
//                         child: Row(
//                           children: [
//                             Icon(
//                               pages.iconPage,
//                               color: value.indexScreen == index
//                                   ? theme.primaryColor
//                                   : Colors.grey,
//                               size: fullWidth < maxWidth ? 15.sp : 15,
//                             ),
//                             SizedBox(
//                               width: fullWidth < maxWidth ? 10.w : 10,
//                             ),
//                             Text(
//                               pages.labelPages!,
//                               style: TextStyle(
//                                 fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                                 color: value.indexScreen == index
//                                     ? theme.primaryColor
//                                     : Colors.grey,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ))),
//         const Spacer(),
//         Container(
//             padding: EdgeInsets.only(bottom: fullWidth < maxWidth ? 10.h : 10),
//             height: fullWidth < maxWidth ? 150.h : 150,
//             alignment: Alignment.bottomCenter,
//             child: Text(
//               user.data.hotel!,
//               style: TextStyle(color: theme.focusColor),
//               textAlign: TextAlign.center,
//             )),
//         SizedBox(
//           height: fullWidth < maxWidth ? 50.h : 50,
//         )
//       ],
//     ),
//   );
// }
