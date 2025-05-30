// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/screen/manage_departement/widget/create_departement.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/screen/manage_departement/widget/edit_departement.dart';
// import 'package:post_app/controller/c_user.dart';
// import 'package:post_app/models/departement_model.dart';
// import 'package:provider/provider.dart';
// import 'dart:io' show Platform;

// class ManageDepartement extends StatelessWidget {
//   const ManageDepartement({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Get.put(CUser());
//     final theme = Theme.of(context);
//     final event = Provider.of<AdminController>(context, listen: false);
//     final isAndroid = Platform.isAndroid;
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: theme.primaryColor,
//           tooltip: "Create departement",
//           elevation: 0,
//           onPressed: () {
//             event.cleaner();
//             Get.to(() => const CreateDepartement(),
//                 transition: Transition.downToUp);
//           },
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//             size: fullWidth < maxWidth ? 20.sp : 20,
//           ),
//         ),
//         appBar: AppBar(
//           centerTitle: false,
//           elevation: 1,
//           leadingWidth: fullWidth < maxWidth ? 30.sp : 30,
//           leading: InkWell(
//             borderRadius:
//                 BorderRadius.circular(fullWidth < maxWidth ? 50.r : 50),
//             onTap: () => Get.back(),
//             child: Padding(
//               padding: EdgeInsets.only(left: fullWidth < maxWidth ? 15.sp : 15),
//               child: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: fullWidth < maxWidth ? 25.sp : 25,
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     color: theme.primaryColor,
//                   )),
//             ),
//           ),
//           backgroundColor: theme.scaffoldBackgroundColor,
//           title: Text(
//             "Manage Departement",
//             style: TextStyle(
//                 color: theme.focusColor,
//                 fontSize: fullWidth < maxWidth ? 20.sp : 20),
//           ),
//         ),
//         body: Consumer<HomeController>(
//           builder: (context, value, child) => Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: fullWidth < maxWidth ? 10.h : 10,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(fullWidth < maxWidth ? 8.sp : 8),
//                 child: Text(
//                   "The active button is the department that can receive tasks",
//                   style: TextStyle(
//                       fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                       color: theme.focusColor),
//                 ),
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 5.h : 5,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: value.listDepartement.length,
//                   itemBuilder: (context, index) {
//                     Departement dept = value.listDepartement[index];
//                     if (value.listDepartement.isEmpty) {
//                       return Center(
//                         child: Text(
//                           "No departement created yet",
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: fullWidth < maxWidth ? 16.sp : 16),
//                         ),
//                       );
//                     }
//                     return ListTile(
//                         onTap: () {
//                           event.activateButton(dept.isActive!);
//                           event.cleaner();
//                           Get.to(
//                               () => EditDepartement(
//                                     departement: dept,
//                                   ),
//                               transition: Transition.rightToLeft);
//                         },
//                         leading: Image.asset(
//                           dept.departementIcon!,
//                           width: fullWidth < maxWidth ? 30.w : 30,
//                           height: fullWidth < maxWidth ? 30.h : 30,
//                         ),
//                         title: Text(
//                           dept.departement!,
//                           style: TextStyle(
//                               fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                               color: theme.focusColor),
//                         ),
//                         trailing: isAndroid
//                             ? Transform.scale(
//                                 scale: 0.8,
//                                 child: Switch(
//                                   inactiveThumbColor: theme.primaryColor,
//                                   activeTrackColor: theme.primaryColor,
//                                   value: dept.isActive!,
//                                   onChanged: (value) =>
//                                       event.updateActiveDepartement(
//                                           context: context,
//                                           hotel: user.data.hotel!,
//                                           newValue: value,
//                                           departement: dept.departement!),
//                                 ),
//                               )
//                             : Transform.scale(
//                                 scale: 0.8,
//                                 child: Switch.adaptive(
//                                   inactiveThumbColor: theme.primaryColor,
//                                   activeTrackColor: theme.primaryColor,
//                                   value: dept.isActive!,
//                                   onChanged: (value) =>
//                                       event.updateActiveDepartement(
//                                           context: context,
//                                           hotel: user.data.hotel!,
//                                           newValue: value,
//                                           departement: dept.departement!),
//                                 ),
//                               ));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
