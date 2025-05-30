// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/common_widget/form_create_account.dart';
// import 'package:post_app/core.dart';
// import 'package:provider/provider.dart';

// import '../../../../../../../../common_widget/dialog_role.dart';
// import '../../../../../../home_controller.dart';
// import 'dialog_all_departement.dart';

// class EmployeeProfile extends StatelessWidget {
//   const EmployeeProfile({super.key, required this.user});
//   final UserDetails user;

//   @override
//   Widget build(BuildContext context) {
//     final event = Provider.of<AdminController>(context, listen: false);
//     final theme = Theme.of(context);
//     return Scaffold(
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
//           backgroundColor: theme.cardColor,
//           title: Text(
//             user.name!,
//             style: TextStyle(color: theme.focusColor),
//           ),
//         ),
//         body: Consumer2<AdminController, HomeController>(
//             builder: (context, value, value2, child) {
//           return ListView(
//             padding: EdgeInsets.all(10.sp),
//             children: [
//               SizedBox(
//                 height: 20.h,
//               ),
//               Text(
//                 "Edit Profile",
//                 style: TextStyle(
//                     fontSize: 16.sp, color: theme.focusColor.withOpacity(0.3)),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               FormCreateAcount(
//                 enterButtonAction: TextInputAction.next,
//                 label: user.name!,
//                 textContronller: value.editname,
//               ),
//               SizedBox(
//                 height: 10.sp,
//               ),
//               Column(
//                 children: [
//                   InkWell(
//                     borderRadius: BorderRadius.circular(13.r),
//                     onTap: () => showAllDepartement(
//                       context: context,
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.all(10.sp),
//                       alignment: Alignment.centerLeft,
//                       height: 50.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(13.r),
//                           border: Border.all(
//                               color: theme.focusColor.withOpacity(0.3))),
//                       child: Text(
//                         value.departement == "Select Departement"
//                             ? user.department!
//                             : value.departement,
//                         style: TextStyle(
//                             fontSize: 16.sp,
//                             color: theme.focusColor.withOpacity(0.3)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Select role of user:",
//                         style: TextStyle(
//                             fontSize: 14.sp,
//                             color: theme.focusColor.withOpacity(0.3)),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.sp,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(13.r),
//                     onTap: () => showRoleDialog(
//                       context: context,
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.all(10.sp),
//                       alignment: Alignment.centerLeft,
//                       height: 50.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(13.r),
//                           border: Border.all(
//                               color: theme.focusColor.withOpacity(0.3))),
//                       child: Text(
//                         value.roleSelected == "User"
//                             ? user.accountType!
//                             : value.roleSelected,
//                         style: TextStyle(
//                             fontSize: 16.sp,
//                             color: theme.focusColor.withOpacity(0.3)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20.sp),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 35.h,
//                       width: double.infinity,
//                       child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(
//                                 color: theme.focusColor.withOpacity(0.3)),
//                             foregroundColor: theme.focusColor,
//                           ),
//                           onPressed: () => Navigator.of(context).pop(),
//                           child: Text("Cancel")),
//                     ),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     SizedBox(
//                       height: 35.h,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: theme.primaryColor,
//                           ),
//                           onPressed: () async {
//                             event.editProfile(
//                                 context: context,
//                                 name: user.name!,
//                                 email: user.email!,
//                                 role: value.roleSelected == "User"
//                                     ? user.accountType!
//                                     : value.roleSelected,
//                                 hotel: user.hotel!,
//                                 editDept:
//                                     value.departement == "Select Departement"
//                                         ? user.department!
//                                         : value.departement);
//                           },
//                           child: Text(
//                             "Save",
//                             style: TextStyle(color: theme.focusColor),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }));
//   }
// }
