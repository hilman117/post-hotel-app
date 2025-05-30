// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
// import 'package:post_app/Screens/chatroom/widget/pop_up_menu/add_schedule.dart';
// import 'package:post_app/Screens/chatroom/widget/pop_up_menu/dialog_location.dart';
// import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
// import 'package:provider/provider.dart';
// import '../../../create/create_request_controller.dart';
// import '../../../create/widget/dialog_title.dart';
// import 'delete_schedule.dart';
// import 'dialog_edit_schedule.dart';

// void showPopUpMenu(BuildContext context, String selectedDept, String tasksId,
//     String emailSender, String oldDate, String oldTime, String location) async {
//   final app = AppLocalizations.of(context);
//   final provider = Provider.of<CreateRequestController>(context, listen: false);
//   final controller = Provider.of<ChatRoomController>(context, listen: false);
//   double size = Get.height + Get.width;
//   final theme = Theme.of(context);
//   await showMenu(
//       elevation: 1,
//       color: theme.cardColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//       context: context,
//       position: RelativeRect.fromLTRB(size * 0.2, size * 0.4, 1, size * 0.0),
//       items: [
//         if (provider.datePicked != '' || provider.selectedTime != '')
//           PopupMenuItem(
//             value: 'Edit Due Date',
//             onTap: () {
//               Future.delayed(
//                 Duration.zero,
//                 () {
//                   editSchedule(context, tasksId, emailSender, oldDate, oldTime,
//                       location);
//                 },
//               );
//             },
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.schedule,
//                   color: Colors.grey.shade400,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   app!.editDueDate,
//                   style: TextStyle(color: theme.focusColor),
//                 ),
//               ],
//             ),
//           ),
//         if (provider.datePicked != '' || provider.selectedTime != '')
//           PopupMenuItem(
//             value: 'Delete Due Date',
//             onTap: () => Future.delayed(
//                 Duration.zero,
//                 () => deleteSchedule(
//                     context, tasksId, emailSender, oldDate, oldTime, location)),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.delete,
//                   color: Colors.grey.shade400,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   app!.deleteDueDate,
//                   style: TextStyle(color: theme.focusColor),
//                 ),
//               ],
//             ),
//           ),
//         if (provider.datePicked == '' || provider.selectedTime == '')
//           PopupMenuItem(
//             value: 'Add Due Date',
//             onTap: () {
//               Future.delayed(
//                 Duration.zero,
//                 () {
//                   addSchedule(context, tasksId, emailSender, oldDate, oldTime,
//                       location);
//                 },
//               );
//             },
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.add,
//                   color: Colors.grey.shade400,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   app!.addDueDate,
//                   style: TextStyle(color: theme.focusColor),
//                 ),
//               ],
//             ),
//           ),
//         PopupMenuItem(
//           value: 'On Hold',
//           onTap: controller.status != "Hold"
//               ? () => Provider.of<PopUpMenuProvider>(context, listen: false)
//                   .holdFunction(context, tasksId, emailSender, location)
//               : () => Provider.of<PopUpMenuProvider>(context, listen: false)
//                   .resumeFunction(context, tasksId, emailSender, location),
//           child: Row(
//             children: [
//               Icon(
//                 controller.status != "Hold" ? Icons.pause : Icons.play_arrow,
//                 color: Colors.grey.shade400,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 controller.status != "Hold" ? app!.onHold : "Resume",
//                 style: TextStyle(color: theme.focusColor),
//               ),
//             ],
//           ),
//         ),
//         PopupMenuItem(
//           value: 'Edit title',
//           onTap: () {
//             Future.delayed(Duration.zero, () {
//               Provider.of<PopUpMenuProvider>(context, listen: false)
//                   .isChangeTitle(true);

//               titleList(
//                 context,
//                 tasksId,
//                 emailSender,
//               );
//             });
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.edit,
//                 color: Colors.grey.shade400,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 app!.editTitle,
//                 style: TextStyle(color: theme.focusColor),
//               ),
//             ],
//           ),
//         ),
//         PopupMenuItem(
//           value: 'Edit location',
//           onTap: () {
//             Future.delayed(
//               Duration.zero,
//               () async {
//                 await Provider.of<PopupMenuButton>(context, listen: false);
//                 // ignore: use_build_context_synchronously
//                 await listLoaction(context, tasksId, emailSender, location);
//               },
//             );
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.location_on_sharp,
//                 color: Colors.grey.shade400,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 app.editLocation,
//                 style: TextStyle(color: theme.focusColor),
//               ),
//             ],
//           ),
//         ),
//       ]);
// }
