// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
// import 'package:post_app/Screens/example/general_widget.dart';
// import 'package:post_app/global_function.dart';
// import 'package:post_app/service/theme.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../../models/tasks.dart';
// import 'group_list.dart';
// import 'list_employee.dart';

// Future assign(
//     BuildContext context,
//     TaskModel task,
//     String taskId,
//     String emailSender,
//     String location,
//     String title,
//     ScrollController scroll) {
//   final theme = Theme.of(context);
//   final provider = Provider.of<ChatRoomController>(context, listen: false);
//   // ignore: unused_local_variable
//   bool choose = false;
//   double fullWidth = MediaQuery.of(context).size.width;
//   double maxWidth = 500;
//   return showAnimatedDialog(
//       animationType: DialogTransitionType.slideFromRight,
//       context: context,
//       builder: (context) {
//         if (Platform.isIOS) {
//           return StatefulBuilder(
//             builder: (context, setState) => Center(
//               child: CupertinoAlertDialog(
//                 content: Material(
//                   color: Colors.transparent,
//                   child: SizedBox(
//                     height: fullWidth < maxWidth ? 450.h : 450,
//                     child: IosContentAssignDialog(
//                         isIos: true,
//                         theme: theme,
//                         fullWidth: fullWidth,
//                         maxWidth: maxWidth,
//                         provider: provider,
//                         taskId: taskId,
//                         emailSender: emailSender,
//                         location: location,
//                         title: title,
//                         scroll: scroll),
//                   ),
//                 ),
//                 actions: [
//                   CupertinoButton(
//                     child: Text(
//                       AppLocalizations.of(context)!.cancel,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       provider.clearListAssign();
//                     },
//                   ),
//                   Consumer<ChatRoomController>(
//                       builder: (context, value, child) {
//                     return CupertinoButton(
//                       child: Text(
//                         AppLocalizations.of(context)!.assign,
//                       ),
//                       onPressed: () {
//                         if (value.departmentsAndNamesSelected.isEmpty) {
//                           Fluttertoast.showToast(
//                               msg: "Please Select Receiver",
//                               backgroundColor: Colors.white,
//                               textColor: Colors.black);
//                         } else {
//                           if (Provider.of<GlobalFunction>(context,
//                                       listen: false)
//                                   .hasInternetConnection ==
//                               true) {
//                             provider.assign(context, task, scroll);
//                           } else {
//                             Provider.of<GlobalFunction>(context, listen: false)
//                                 .noInternet();
//                           }
//                         }
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           );
//         }
//         return Consumer<ChatRoomController>(
//           builder: (context, value, child) => StatefulBuilder(
//               builder: (context, setState) => Center(
//                     child: SingleChildScrollView(
//                       child: Dialog(
//                           insetPadding:
//                               EdgeInsets.all(fullWidth < maxWidth ? 15.sp : 15),
//                           backgroundColor: theme.scaffoldBackgroundColor,
//                           shadowColor: Colors.transparent,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   fullWidth < maxWidth ? 10.r : 10)),
//                           child: ContentAssignDialog(
//                             theme: theme,
//                             fullWidth: fullWidth,
//                             maxWidth: maxWidth,
//                             provider: provider,
//                             scroll: scroll,
//                             taskModel: task,
//                           )),
//                     ),
//                   )),
//         );
//       });
// }

// class ContentAssignDialog extends StatelessWidget {
//   const ContentAssignDialog({
//     super.key,
//     required this.theme,
//     required this.fullWidth,
//     required this.maxWidth,
//     required this.provider,
//     required this.scroll,
//     this.isIos = false,
//     required this.taskModel,
//   });

//   final ThemeData theme;
//   final bool? isIos;
//   final double fullWidth;
//   final double maxWidth;
//   final TaskModel taskModel;
//   final ScrollController scroll;

//   final ChatRoomController provider;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 2000),
//       decoration: BoxDecoration(
//           color: theme.scaffoldBackgroundColor,
//           borderRadius:
//               BorderRadius.circular(fullWidth < maxWidth ? 16.r : 16)),
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: fullWidth < maxWidth ? 10.sp : 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: fullWidth < maxWidth ? 25.h : 25),
//             Text(
//                 "${AppLocalizations.of(context)!.assign} ${AppLocalizations.of(context)!.to}:",
//                 style: TextStyle(
//                     fontSize: fullWidth < maxWidth ? 18.sp : 18,
//                     color: theme.focusColor)),
//             Container(
//               padding: EdgeInsets.symmetric(
//                   vertical: fullWidth < maxWidth ? 10.sp : 10),
//               width: double.infinity,
//               height: fullWidth < maxWidth ? 45.h : 45,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(fullWidth < maxWidth ? 4.r : 4),
//                 color: theme.cardColor,
//               ),
//               child: Row(
//                 children: [
//                   Row(
//                     children: [
//                       Consumer<ChatRoomController>(
//                           builder: (context, value, child) => Radio<int>(
//                               activeColor: theme.primaryColor,
//                               value: 0,
//                               groupValue: value.radioValue,
//                               onChanged: (value) {
//                                 provider.valueRadio0();
//                               })),
//                       Text(
//                         "Grup",
//                         style: TextStyle(
//                             fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                             color: theme.focusColor),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: fullWidth < maxWidth ? 50.w : 50,
//                   ),
//                   Row(
//                     children: [
//                       Consumer<ChatRoomController>(
//                           builder: (context, value, child) => Radio<int>(
//                                 activeColor: Colors.grey,
//                                 value: 1,
//                                 groupValue: value.radioValue,
//                                 onChanged: (value) {
//                                   provider.valueRadio1();
//                                 },
//                               )),
//                       Text(
//                         "Users",
//                         style: TextStyle(
//                             fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                             color: theme.focusColor),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 Icon(
//                   Icons.search,
//                   color: Colors.grey.shade400,
//                   size: fullWidth < maxWidth ? 20.sp : 20,
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: fullWidth < maxWidth ? 35.h : 35,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           bottom: fullWidth < maxWidth ? 5.sp : 5),
//                       child: Consumer<ChatRoomController>(
//                           builder: (context, value, child) => TextFormField(
//                                 cursorColor: mainColor,
//                                 style: const TextStyle(color: Colors.grey),
//                                 onChanged: (value) {
//                                   provider.searchFuntion(value);
//                                 },
//                                 controller: value.searchController,
//                                 textAlignVertical: TextAlignVertical.top,
//                                 decoration: InputDecoration(
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: mainColor)),
//                                     border: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: mainColor)),
//                                     hintStyle: const TextStyle(
//                                         color: Colors.grey,
//                                         fontStyle: FontStyle.italic),
//                                     hintText:
//                                         AppLocalizations.of(context)!.search,
//                                     contentPadding: EdgeInsets.only(
//                                         bottom:
//                                             fullWidth < maxWidth ? 15.sp : 15)),
//                               )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Consumer<ChatRoomController>(
//                 builder: (context, value, child) => AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 500),
//                     child: value.isGroup
//                         ? LimitedBox(
//                             maxHeight: fullWidth < maxWidth ? 300.h : 300,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: theme.cardColor,
//                                   borderRadius: BorderRadius.circular(
//                                       fullWidth < maxWidth ? 16.r : 16)),
//                               child: ListView.builder(
//                                   padding: const EdgeInsets.all(0),
//                                   shrinkWrap: true,
//                                   itemCount: value.departments.length,
//                                   itemBuilder: (context, index) {
//                                     if (value.textInput.isEmpty) {
//                                       return listOfGroup(
//                                           value.departments[index], index);
//                                     }
//                                     if (value.departments[index]
//                                         .toString()
//                                         .toLowerCase()
//                                         .contains(
//                                             value.textInput.toLowerCase())) {
//                                       return listOfGroup(
//                                           value.departments[index], index);
//                                     }
//                                     return const SizedBox();
//                                   }),
//                             ),
//                           )
//                         : LimitedBox(
//                             maxHeight: fullWidth < maxWidth ? 300.h : 300,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: theme.cardColor,
//                                   borderRadius: BorderRadius.circular(
//                                       fullWidth < maxWidth ? 16.r : 16)),
//                               child: ListView.builder(
//                                   padding: const EdgeInsets.all(0),
//                                   shrinkWrap: true,
//                                   itemCount: value.names.length,
//                                   itemBuilder: (context, index) {
//                                     if (value.textInput.isEmpty) {
//                                       return listOfEmployee(
//                                           context,
//                                           value.names[index],
//                                           value.emailList[index],
//                                           index);
//                                     }
//                                     if (value.names[index]
//                                         .toString()
//                                         .toLowerCase()
//                                         .contains(
//                                             value.textInput.toLowerCase())) {
//                                       return listOfEmployee(
//                                           context,
//                                           value.names[index],
//                                           value.emailList[index],
//                                           index);
//                                     }
//                                     return const SizedBox();
//                                   }),
//                             ),
//                           ))),
//             SizedBox(
//               height: fullWidth < maxWidth ? 10.h : 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SizedBox(
//                   width: fullWidth < maxWidth ? 100.w : 100,
//                   height: fullWidth < maxWidth ? 30.h : 30,
//                   child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   fullWidth < maxWidth ? 4.r : 4)),
//                           foregroundColor: secondary.withOpacity(0.5)),
//                       onPressed: () async {
//                         Navigator.pop(context);
//                         provider.clearListAssign();
//                       },
//                       child: Text(
//                         AppLocalizations.of(context)!.cancel,
//                         style: TextStyle(
//                             color: theme.primaryColor,
//                             fontSize: fullWidth < maxWidth ? 14.sp : 14),
//                       )),
//                 ),
//                 Consumer<ChatRoomController>(
//                     builder: (context, value, child) => SizedBox(
//                           width: fullWidth < maxWidth ? 100.w : 100,
//                           height: fullWidth < maxWidth ? 30.h : 30,
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   foregroundColor: theme.cardColor,
//                                   elevation: 0,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           fullWidth < maxWidth ? 4.r : 4)),
//                                   backgroundColor: theme.primaryColor),
//                               onPressed: () {
//                                 if (value.departmentsAndNamesSelected.isEmpty) {
//                                   Fluttertoast.showToast(
//                                       msg: "Please Select Receiver",
//                                       backgroundColor: Colors.white,
//                                       textColor: Colors.black);
//                                 } else {
//                                   if (Provider.of<GlobalFunction>(context,
//                                               listen: false)
//                                           .hasInternetConnection ==
//                                       true) {
//                                     provider.assign(context, taskmodel, scroll);
//                                   } else {
//                                     Provider.of<GlobalFunction>(context,
//                                             listen: false)
//                                         .noInternet();
//                                   }
//                                 }
//                               },
//                               child: Text(
//                                 AppLocalizations.of(context)!.assign,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize:
//                                         fullWidth < maxWidth ? 14.sp : 14),
//                               )),
//                         ))
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IosContentAssignDialog extends StatelessWidget {
//   const IosContentAssignDialog({
//     super.key,
//     required this.theme,
//     required this.fullWidth,
//     required this.maxWidth,
//     required this.provider,
//     required this.taskId,
//     required this.emailSender,
//     required this.location,
//     required this.title,
//     required this.scroll,
//     this.isIos = false,
//   });

//   final ThemeData theme;
//   final bool? isIos;
//   final double fullWidth;
//   final double maxWidth;
//   final String taskId;
//   final String emailSender;
//   final String location;
//   final String title;
//   final ScrollController scroll;

//   final ChatRoomController provider;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 2000),
//       decoration: BoxDecoration(
//           // color: theme.scaffoldBackgroundColor,
//           borderRadius:
//               BorderRadius.circular(fullWidth < maxWidth ? 16.r : 16)),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: fullWidth < maxWidth ? 25.h : 25),
//           Text(
//               "${AppLocalizations.of(context)!.assign} ${AppLocalizations.of(context)!.to}:",
//               style: TextStyle(
//                   fontSize: fullWidth < maxWidth ? 18.sp : 18,
//                   color: theme.focusColor)),
//           Container(
//             padding: EdgeInsets.symmetric(
//                 vertical: fullWidth < maxWidth ? 10.sp : 10),
//             width: double.infinity,
//             height: fullWidth < maxWidth ? 45.h : 45,
//             decoration: BoxDecoration(
//               borderRadius:
//                   BorderRadius.circular(fullWidth < maxWidth ? 4.r : 4),
//               // color: theme.cardColor,
//             ),
//             child: Row(
//               children: [
//                 Row(
//                   children: [
//                     Consumer<ChatRoomController>(
//                         builder: (context, value, child) => Radio<int>(
//                             activeColor: theme.primaryColor,
//                             value: 0,
//                             groupValue: value.radioValue,
//                             onChanged: (value) {
//                               provider.valueRadio0();
//                             })),
//                     Text(
//                       "Grup",
//                       style: TextStyle(
//                           fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                           color: theme.focusColor),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: fullWidth < maxWidth ? 30.w : 50,
//                 ),
//                 Row(
//                   children: [
//                     Consumer<ChatRoomController>(
//                         builder: (context, value, child) => Radio<int>(
//                               activeColor: Colors.grey,
//                               value: 1,
//                               groupValue: value.radioValue,
//                               onChanged: (value) {
//                                 provider.valueRadio1();
//                               },
//                             )),
//                     Text(
//                       "Users",
//                       style: TextStyle(
//                           fontSize: fullWidth < maxWidth ? 14.sp : 14,
//                           color: theme.focusColor),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.search,
//                 color: Colors.grey.shade400,
//                 size: fullWidth < maxWidth ? 20.sp : 20,
//               ),
//               Expanded(
//                 child: SizedBox(
//                   height: fullWidth < maxWidth ? 35.h : 35,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         bottom: fullWidth < maxWidth ? 5.sp : 5),
//                     child: Consumer<ChatRoomController>(
//                         builder: (context, value, child) => TextFormField(
//                               cursorColor: mainColor,
//                               style: const TextStyle(color: Colors.grey),
//                               onChanged: (value) {
//                                 provider.searchFuntion(value);
//                               },
//                               controller: value.searchController,
//                               textAlignVertical: TextAlignVertical.top,
//                               decoration: InputDecoration(
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(color: mainColor)),
//                                   border: UnderlineInputBorder(
//                                       borderSide: BorderSide(color: mainColor)),
//                                   hintStyle: const TextStyle(
//                                       color: Colors.grey,
//                                       fontStyle: FontStyle.italic),
//                                   hintText:
//                                       AppLocalizations.of(context)!.search,
//                                   contentPadding: EdgeInsets.only(
//                                       bottom:
//                                           fullWidth < maxWidth ? 15.sp : 15)),
//                             )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Consumer<ChatRoomController>(
//               builder: (context, value, child) => AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 500),
//                   child: value.isGroup
//                       ? LimitedBox(
//                           maxHeight: fullWidth < maxWidth ? 300.h : 300,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: theme.cardColor,
//                                 borderRadius: BorderRadius.circular(
//                                     fullWidth < maxWidth ? 16.r : 16)),
//                             child: ListView.builder(
//                                 padding: const EdgeInsets.all(0),
//                                 shrinkWrap: true,
//                                 itemCount: value.departments.length,
//                                 itemBuilder: (context, index) {
//                                   if (value.textInput.isEmpty) {
//                                     return listOfGroup(
//                                         value.departments[index], index);
//                                   }
//                                   if (value.departments[index]
//                                       .toString()
//                                       .toLowerCase()
//                                       .contains(
//                                           value.textInput.toLowerCase())) {
//                                     return listOfGroup(
//                                         value.departments[index], index);
//                                   }
//                                   return const SizedBox();
//                                 }),
//                           ),
//                         )
//                       : LimitedBox(
//                           maxHeight: fullWidth < maxWidth ? 300.h : 300,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: theme.cardColor,
//                                 borderRadius: BorderRadius.circular(
//                                     fullWidth < maxWidth ? 16.r : 16)),
//                             child: ListView.builder(
//                                 padding: const EdgeInsets.all(0),
//                                 shrinkWrap: true,
//                                 itemCount: value.names.length,
//                                 itemBuilder: (context, index) {
//                                   if (value.textInput.isEmpty) {
//                                     return listOfEmployee(
//                                         context,
//                                         value.names[index],
//                                         value.emailList[index],
//                                         index);
//                                   }
//                                   if (value.names[index]
//                                       .toString()
//                                       .toLowerCase()
//                                       .contains(
//                                           value.textInput.toLowerCase())) {
//                                     return listOfEmployee(
//                                         context,
//                                         value.names[index],
//                                         value.emailList[index],
//                                         index);
//                                   }
//                                   return const SizedBox();
//                                 }),
//                           ),
//                         ))),
//           SizedBox(
//             height: 10.h,
//           ),
//         ],
//       ),
//     );
//   }
// }
