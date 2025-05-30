// import 'dart:io';

// import 'package:floating_action_bubble/floating_action_bubble.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/home_controller.dart';
// import 'package:provider/provider.dart';

// import '../../../models/departement_model.dart';
// import '../../create/create_request.dart';
// import '../../ios_view/ios_bottom_departement.dart';
// import 'dialog_departement_list.dart';

// class FloatingBubble extends StatefulWidget {
//   const FloatingBubble({super.key});

//   @override
//   State<FloatingBubble> createState() => _FloatingBubbleState();
// }

// class _FloatingBubbleState extends State<FloatingBubble>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> _animation;
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 260),
//     );

//     final curvedAnimation =
//         CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Consumer<HomeController>(
//         builder: (context, value, child) => FloatingActionBubble(
//               // Menu items
//               items: <Bubble>[
//                 //Floating action menu item
//                 Bubble(
//                   title: "Create task",
//                   iconColor: Colors.white,
//                   bubbleColor: theme.primaryColor,
//                   icon: Icons.home,
//                   titleStyle: TextStyle(
//                       letterSpacing: -0.5,
//                       fontSize: 16.sp,
//                       color: Colors.white),
//                   onPress: () {
//                     if (Platform.isIOS) {
//                       showDepartmentCupertinoModal(context);
//                       _animationController.reverse();
//                     } else {
//                       showDepartementDialog(context);
//                       _animationController.reverse();
//                     }
//                   },
//                 ),
//                 // Floating action menu item
//                 Bubble(
//                   title: "Lost and found report",
//                   iconColor: Colors.white,
//                   bubbleColor: theme.primaryColor,
//                   icon: Icons.youtube_searched_for_outlined,
//                   titleStyle: TextStyle(
//                       letterSpacing: -0.5,
//                       fontSize: 16.sp,
//                       color: Colors.white),
//                   onPress: () {
//                     Departement deptForStoreLf = value.listDepartement
//                         .firstWhere(
//                             (element) => element.departement == "Housekeeping");
//                     Get.to(
//                         () => CreateRequest(
//                             listTitle: const [],
//                             selectedDept: deptForStoreLf,
//                             isTask: false),
//                         transition: Transition.rightToLeft);
//                     _animationController.reverse();
//                   },
//                 ),
//               ],

//               // animation controller
//               animation: _animation,

//               // On pressed change animation state
//               onPress: () => _animationController.isCompleted
//                   ? _animationController.reverse()
//                   : _animationController.forward(),

//               // Floating Action button Icon color
//               iconColor: Colors.white,

//               // Flaoting Action button Icon
//               iconData: _animationController.isCompleted
//                   ? Icons.cancel_outlined
//                   : Icons.notification_add_outlined,
//               backGroundColor: theme.primaryColor,
//             ));
//   }
// }
