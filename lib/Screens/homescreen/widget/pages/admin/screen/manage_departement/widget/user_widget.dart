// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// import '../../../../../../../../common_widget/show_dialog.dart';
// import '../../../../../../../../models/departement_model.dart';
// import '../../../../../../../../models/user.dart';
// import '../../../admin_controller.dart';
// import 'create_account.dart';
// import 'employee_profile.dart';

// class UserWidet extends StatelessWidget {
//   const UserWidet({
//     super.key,
//     required this.theme,
//     required this.event,
//     required this.departement,
//   });

//   final ThemeData theme;
//   final AdminController event;
//   final Departement departement;

//   @override
//   Widget build(BuildContext context) {
//     bool isDark = theme.brightness == Brightness.dark;
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     return Consumer<AdminController>(
//       builder: (context, value, child) => Card(
//         elevation: isDark ? 0 : 1,
//         color: theme.cardColor,
//         margin: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//         child: Padding(
//           padding: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                 child: Text(
//                   "User",
//                   style: TextStyle(
//                       fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                       color: theme.focusColor),
//                 ),
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 10.h : 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: fullWidth < maxWidth ? 35.h : 35,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: fullWidth < maxWidth ? 10.sp : 10),
//                       child: SearchBar(
//                         elevation: MaterialStateProperty.resolveWith((states) =>
//                             ThemeMode.system == ThemeMode.dark ? 0 : 1),
//                         backgroundColor:
//                             MaterialStateProperty.resolveWith<Color?>(
//                           (Set<MaterialState> states) {
//                             // Warna saat tombol dalam keadaan normal atau lainnya.
//                             return theme.scaffoldBackgroundColor;
//                           },
//                         ),
//                         controller: value.userController,
//                         hintText: "Search user",
//                         hintStyle: MaterialStateProperty.resolveWith(
//                             (states) => const TextStyle(color: Colors.grey)),
//                         onChanged: (value) {
//                           event.searching(user: value);
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: fullWidth < maxWidth ? 10.sp : 10,
//                         right: fullWidth < maxWidth ? 20.sp : 20),
//                     child: Tooltip(
//                       message: "Add user",
//                       child: InkWell(
//                         onTap: () => Get.to(
//                             () => CreateAccount(
//                                   departement: departement.departement!,
//                                 ),
//                             transition: Transition.downToUp),
//                         child: CircleAvatar(
//                           backgroundColor: theme.scaffoldBackgroundColor,
//                           child: Icon(
//                             Icons.add,
//                             color: theme.focusColor,
//                             size: fullWidth < maxWidth ? 20.sp : 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: fullWidth < maxWidth ? 10.h : 10,
//               ),
//               LimitedBox(
//                 maxHeight: fullWidth < maxWidth ? 300.h : 300,
//                 child:
//                     Consumer<AdminController>(builder: (context, value, child) {
//                   var list = value.listEmployee
//                       .where((element) =>
//                           element.department == departement.departement)
//                       .toList();
//                   return ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: list.length,
//                       itemBuilder: (context, index) {
//                         UserDetails user = list[index];
//                         if (user.name!
//                             .toLowerCase()
//                             .contains(value.searchUser.toLowerCase())) {
//                           return ListTile(
//                             dense: true,
//                             visualDensity: const VisualDensity(
//                                 horizontal: 0, vertical: -4),
//                             contentPadding: EdgeInsets.zero,
//                             minVerticalPadding: 0,
//                             trailing: IconButton(
//                                 splashRadius: fullWidth < maxWidth ? 25.sp : 25,
//                                 onPressed: () => ShowDialog().confirmDialog(
//                                         context,
//                                         "Are you sure want to delete ${user.name}?",
//                                         () async {
//                                       await event.deleteUser(
//                                           context: context,
//                                           name: user.name!,
//                                           email: user.email!);
//                                       // ignore: use_build_context_synchronously
//                                       Navigator.of(context).pop();
//                                     }),
//                                 icon: Icon(
//                                   Icons.delete,
//                                   color: theme.focusColor,
//                                   size: fullWidth < maxWidth ? 25.sp : 25,
//                                 )),
//                             onTap: () => Get.to(
//                                 () => EmployeeProfile(
//                                       user: user,
//                                     ),
//                                 transition: Transition.rightToLeft),
//                             title: Text(
//                               user.name!,
//                               style: TextStyle(
//                                   fontSize: fullWidth < maxWidth ? 16.sp : 16,
//                                   color: theme.focusColor),
//                             ),
//                             subtitle: Text(
//                               user.email!,
//                               style: TextStyle(
//                                   fontSize: fullWidth < maxWidth ? 11.sp : 11,
//                                   color: theme.focusColor),
//                             ),
//                             isThreeLine: true,
//                           );
//                         }
//                         return const SizedBox();
//                       });
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
