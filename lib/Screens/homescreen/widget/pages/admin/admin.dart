// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
// import 'package:post_app/Screens/homescreen/widget/pages/admin/screen/manage_departement/manage_departement.dart';
// import 'package:post_app/controller/c_user.dart';
// import 'package:provider/provider.dart';

// import '../../../../../common_widget/form_create_account.dart';
// import '../../../../../common_widget/show_dialog.dart';

// class Admin extends StatelessWidget {
//   const Admin({super.key, required this.screen});

//   final int screen;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final event = Provider.of<AdminController>(context, listen: false);
//     final eventHome = Provider.of<HomeController>(context, listen: false);
//     final user = Get.put(CUser());
//     double fullWidth = MediaQuery.of(context).size.width;
//     double maxWidth = 500;
//     bool isDark = theme.brightness == Brightness.dark;
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//         eventHome.selectScreens(0);

//         return true;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             centerTitle: false,
//             elevation: 1,
//             leadingWidth: fullWidth < maxWidth ? 40.w : 40,
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//                 onPressed: () {
//                   Get.back();
//                   eventHome.selectScreens(0);
//                 },
//                 splashRadius: fullWidth < maxWidth ? 20.r : 20,
//                 color: Colors.blue.shade700,
//                 icon: Icon(
//                   Icons.arrow_back_ios_new,
//                   color: theme.primaryColor,
//                   size: fullWidth < maxWidth ? 20.sp : 20,
//                 )),
//             backgroundColor: theme.cardColor,
//             title: Text(
//               "Admin",
//               style: TextStyle(
//                   color: theme.focusColor,
//                   fontSize: fullWidth < maxWidth ? 20.sp : 20),
//             ),
//           ),
//           backgroundColor: theme.scaffoldBackgroundColor,
//           body: ListView(children: [
//             Card(
//               elevation: isDark ? 0 : 1,
//               color: Colors.transparent,
//               margin: EdgeInsets.symmetric(
//                   vertical: fullWidth < maxWidth ? 13.sp : 13,
//                   horizontal: fullWidth < maxWidth ? 10.sp : 10),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         fullWidth < maxWidth ? 13.r : 13)),
//                 tileColor: theme.cardColor,
//                 onTap: () async {
//                   await event.getEmployeeData(context);
//                   Get.to(() => const ManageDepartement(),
//                       transition: Transition.rightToLeft);
//                 },
//                 subtitle: Text(
//                   "Manage which departement that allowed to receive a task",
//                   style: TextStyle(
//                       fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                       color: theme.focusColor),
//                 ),
//                 leading: Icon(
//                   Icons.manage_accounts,
//                   color: ThemeMode.system == ThemeMode.dark
//                       ? theme.focusColor
//                       : theme.primaryColor,
//                 ),
//                 title: Text(
//                   "Manage Departement",
//                   style: TextStyle(
//                       fontSize: fullWidth < maxWidth ? 20.sp : 20,
//                       color: theme.focusColor),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Card(
//               elevation: isDark ? 0 : 1,
//               color: Colors.transparent,
//               margin: EdgeInsets.symmetric(
//                   horizontal: fullWidth < maxWidth ? 10.sp : 10),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         fullWidth < maxWidth ? 13.r : 13)),
//                 tileColor: theme.cardColor,
//                 onTap: () async {
//                   const CupertinoPage(child: Text("data"));
//                 },
//                 subtitle: Text(
//                   "Departement where lost and found were store",
//                   style: TextStyle(
//                       fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                       color: theme.focusColor),
//                 ),
//                 leading: Icon(
//                   Icons.pin_end,
//                   color: ThemeMode.system == ThemeMode.dark
//                       ? theme.focusColor
//                       : theme.primaryColor,
//                 ),
//                 title:
//                     Consumer<AdminController>(builder: (context, value, child) {
//                   return Text(
//                     value.deptToKeepLF.isEmpty
//                         ? "Lost and found storage"
//                         : value.deptToKeepLF,
//                     style: TextStyle(
//                         fontSize: fullWidth < maxWidth ? 20.sp : 20,
//                         color: theme.focusColor),
//                   );
//                 }),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Consumer2<AdminController, HomeController>(
//                 builder: (context, value, value2, child) => Card(
//                       elevation: isDark ? 0 : 1,
//                       color: theme.cardColor,
//                       margin: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//                       child: Padding(
//                         padding:
//                             EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal:
//                                       fullWidth < maxWidth ? 10.sp : 10),
//                               child: Text(
//                                 "Title",
//                                 style: TextStyle(
//                                     fontSize: fullWidth < maxWidth ? 13.sp : 13,
//                                     color: theme.focusColor),
//                               ),
//                             ),
//                             SizedBox(
//                               height: fullWidth < maxWidth ? 10.h : 10,
//                             ),
//                             ExpansionTile(
//                               initiallyExpanded: value.isCollapseLocation,
//                               onExpansionChanged: (value) {
//                                 event.colapsingPanel(valueLocation: value);
//                               },
//                               trailing: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: fullWidth < maxWidth ? 10.sp : 10,
//                                     right: fullWidth < maxWidth ? 20.sp : 20),
//                                 child: Tooltip(
//                                   message: "Add title",
//                                   child: CircleAvatar(
//                                     backgroundColor:
//                                         theme.scaffoldBackgroundColor,
//                                     child: Icon(
//                                       value.isCollapseLocation
//                                           ? Icons.close_outlined
//                                           : Icons.add,
//                                       color: theme.focusColor,
//                                       size: fullWidth < maxWidth ? 20.sp : 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               tilePadding: EdgeInsets.zero,
//                               title: Container(
//                                 height: fullWidth < maxWidth ? 35.h : 35,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal:
//                                         fullWidth < maxWidth ? 10.sp : 10),
//                                 child: SearchBar(
//                                   elevation: MaterialStateProperty.resolveWith(
//                                       (states) => isDark ? 0 : 1),
//                                   backgroundColor:
//                                       MaterialStateProperty.resolveWith<Color?>(
//                                     (Set<MaterialState> states) {
//                                       // Warna saat tombol dalam keadaan normal atau lainnya.
//                                       return theme.scaffoldBackgroundColor;
//                                     },
//                                   ),
//                                   controller: value.locationSearch,
//                                   hintText: "Search Location",
//                                   onChanged: (value) {
//                                     event.searching(location: value);
//                                   },
//                                   hintStyle: MaterialStateProperty.resolveWith(
//                                       (states) =>
//                                           const TextStyle(color: Colors.grey)),
//                                 ),
//                               ),
//                               children: [
//                                 SizedBox(
//                                   height: fullWidth < maxWidth ? 10.h : 10,
//                                 ),
//                                 FormCreateAcount(
//                                     typingFunction: (val) {
//                                       event.input(newLoc: val);
//                                     },
//                                     label: "Input Location",
//                                     textContronller: value.newLocation),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     OutlinedButton(
//                                         onPressed: value.location.isEmpty
//                                             ? null
//                                             : () => event.addLocation(
//                                                 context, user.data.hotel!),
//                                         child: const Text("Save"))
//                                   ],
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: fullWidth < maxWidth ? 10.h : 10,
//                             ),
//                             AnimatedContainer(
//                               height: fullWidth < maxWidth ? 300.h : 300,
//                               duration: const Duration(milliseconds: 500),
//                               child: AnimatedSwitcher(
//                                   duration: const Duration(milliseconds: 500),
//                                   child: ListView.builder(
//                                       physics: const BouncingScrollPhysics(),
//                                       itemCount: value2.listLocation.length,
//                                       itemBuilder: (context, index) {
//                                         String location =
//                                             value2.listLocation[index];
//                                         if (value2.listLocation[index]
//                                             .toLowerCase()
//                                             .contains(value.searchLocation
//                                                 .toLowerCase())) {
//                                           return ListTile(
//                                             trailing: IconButton(
//                                                 splashRadius:
//                                                     fullWidth < maxWidth
//                                                         ? 20.r
//                                                         : 20,
//                                                 onPressed: () =>
//                                                     ShowDialog().confirmDialog(
//                                                         context,
//                                                         "Are you sure to delete '$location' from list?",
//                                                         () async {
//                                                       await event
//                                                           .deleteLocation(
//                                                               context,
//                                                               user.data.hotel!,
//                                                               value2.dataHotel!
//                                                                   .location!,
//                                                               index);
//                                                       // ignore: use_build_context_synchronously
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     }),
//                                                 icon: Icon(
//                                                   Icons.delete,
//                                                   color: theme.focusColor,
//                                                 )),
//                                             title: Text(
//                                               location,
//                                               style: TextStyle(
//                                                   fontSize: fullWidth < maxWidth
//                                                       ? 15.sp
//                                                       : 15,
//                                                   color: theme.focusColor),
//                                             ),
//                                           );
//                                         }
//                                         return const SizedBox();
//                                       })),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ))
//           ])),
//     );
//   }
// }
