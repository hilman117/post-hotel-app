// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/common_widget/dialog_icon_dept.dart';
// import 'package:post_app/common_widget/form_create_account.dart';
// import 'package:post_app/common_widget/show_dialog.dart';
// import 'package:post_app/controller/c_user.dart';
// import 'package:post_app/models/departement_model.dart';
// import 'package:provider/provider.dart';
// import 'title_widget.dart';
// import 'user_widget.dart';

// class EditDepartement extends StatelessWidget {
//   const EditDepartement({super.key, required this.departement});

//   final Departement departement;
//   static final user = Get.put(CUser());

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final event = Provider.of<AdminController>(context, listen: false);
//     // bool isDark = ThemeMode.system == ThemeMode.dark;
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return Scaffold(
//         appBar: AppBar(
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
//                     color: theme.focusColor,
//                   )),
//             ),
//           ),
//           backgroundColor: theme.cardColor,
//           title: Text(
//             departement.departement!,
//             style: TextStyle(color: theme.focusColor),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => ShowDialog().confirmDialog(
//                     context,
//                     "If you delete this departement all user under this departement will be deleted. Are you sure want to delete?",
//                     () => event.deleteDepartement(
//                         context, departement.departement!, user.data.hotel!)),
//                 child: Text(
//                   "Delete",
//                   style: TextStyle(
//                       color: ThemeMode.system == ThemeMode.dark
//                           ? theme.primaryColor
//                           : Colors.grey),
//                 )),
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Save",
//                   style: TextStyle(
//                       color: ThemeMode.system == ThemeMode.dark
//                           ? Colors.grey
//                           : theme.primaryColor),
//                 ))
//           ],
//         ),
//         backgroundColor: theme.scaffoldBackgroundColor,
//         body: Consumer<AdminController>(
//           builder: (context, value, child) => ListView(
//             children: [
//               SizedBox(
//                 height: fullWidth < maxWidth ? 20.h : 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       borderRadius: BorderRadius.circular(
//                           fullWidth < maxWidth ? 10.r : 10),
//                       onTap: () => dialogIconDept(context: context),
//                       child: Stack(
//                         children: [
//                           Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Icon(
//                                 Icons.edit,
//                                 color: theme.focusColor.withOpacity(0.3),
//                                 size: fullWidth < maxWidth ? 20.sp : 20,
//                               )),
//                           Container(
//                             padding: EdgeInsets.all(
//                                 fullWidth < maxWidth ? 10.sp : 10),
//                             alignment: Alignment.center,
//                             height: fullWidth < maxWidth ? 50.h : 50,
//                             width: fullWidth < maxWidth ? 50.w : 50,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     fullWidth < maxWidth ? 10.r : 10),
//                                 border: Border.all(
//                                     color: theme.focusColor.withOpacity(0.3))),
//                             child: Image.asset(value.selectedIcon == ""
//                                 ? departement.departementIcon!
//                                 : value.selectedIcon),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: fullWidth < maxWidth ? 10.w : 10,
//                     ),
//                     Expanded(
//                       child: FormCreateAcount(
//                           label: departement.departement!,
//                           textContronller: value.editDeptName),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 10.h : 10,
//               ),
//               UserWidet(theme: theme, event: event, departement: departement),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 20.h : 20,
//               ),
//               TitleWidget(event: event, theme: theme, departement: departement),
//             ],
//           ),
//         ));
//   }
// }
