// import 'dart:async';
// import 'dart:io';

// import 'package:automatic_animated_list/automatic_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:post_app/Screens/homescreen/widget/fab_dashboard.dart';
// import 'package:post_app/controller/c_user.dart';
// import 'package:provider/provider.dart';

// import '../../../../models/tasks.dart';
// import '../../home_controller.dart';
// import '../card_request.dart';
// import '../custom_appbar/custom_appbar.dart';
// import '../drawer_widget.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard>
//     with SingleTickerProviderStateMixin {
//   // late ScrollController controller;

//   final cUser = Get.put(CUser());
//   // String? _getFoto;

//   Animatable<Color?> bgColor = TweenSequence<Color?>([
//     TweenSequenceItem(
//         tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
//         weight: 1.0),
//     TweenSequenceItem(
//         tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
//         weight: 1.0),
//     TweenSequenceItem(
//         tween: ColorTween(begin: Colors.white, end: Colors.blue.shade100),
//         weight: 1.0),
//     TweenSequenceItem(
//         tween: ColorTween(begin: Colors.blue.shade100, end: Colors.white),
//         weight: 1.0),
//   ]);

//   late AnimationController _controller;
//   late Animation<Color?> _colorAnimation;
//   Timer? _timer;

//   @override
//   void initState() {
//     _controller = AnimationController(
//         duration: const Duration(seconds: 1),
//         vsync: this,
//         reverseDuration: const Duration(seconds: 1))
//       ..repeat(reverse: true);
//     _startAnimationTimer();
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (mounted) {
//       Future.microtask(
//         () => Provider.of<HomeController>(context, listen: false)
//             .selectScreens(0),
//       );
//     }

//     final theme = Theme.of(context);
//     _colorAnimation = _controller.drive(
//       TweenSequence<Color?>(
//         [
//           TweenSequenceItem(
//             tween: ColorTween(
//               begin: theme.cardColor,
//               end: Colors.blue.shade100,
//             ),
//             weight: 1.0,
//           ),
//           TweenSequenceItem(
//             tween: ColorTween(
//               begin: Colors.blue.shade100,
//               end: theme.cardColor,
//             ),
//             weight: 1.0,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer!.cancel();
//     super.dispose();
//   }

//   void _startAnimationTimer() {
//     const animationDuration = Duration(minutes: 1);
//     const animationInterval = Duration(seconds: 3);

//     _timer = Timer.periodic(animationDuration + animationInterval, (_) {
//       if (mounted) {
//         _controller.forward(from: 0.0);
//         Timer(animationDuration, () {
//           if (mounted) {
//             _controller.stop();
//             setState(() {});
//           }
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tasks = Provider.of<List<TaskModel>>(context);
//     final event = Provider.of<HomeController>(context, listen: false);
//     final theme = Theme.of(context);

//     return Scaffold(
//       // endDrawer: Platform.isIOS ? null : drawerWidet(context),
//       backgroundColor: theme.scaffoldBackgroundColor,
//       floatingActionButton: const FloatingBubble(),
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           Consumer(
//             builder: (context, value, child) => customAppbar(context),
//           )
//         ],
//         // ignore: prefer_const_constructors
//         body: Consumer<HomeController>(builder: (context, value, child) {
//           event.filteredTasks(cUser, tasks);

//           value.filteredListTasks.sort(
//             (a, b) => b.time!.compareTo(a.time!),
//           );
//           return AutomaticAnimatedList<TaskModel>(
//             padding: const EdgeInsets.all(0),
//             items: value.filteredListTasks,
//             keyingFunction: (TaskModel item) => Key(item.id!),
//             insertDuration: const Duration(milliseconds: 300),
//             removeDuration: const Duration(milliseconds: 300),
//             itemBuilder: (context, task, animation) {
//               if (task.sender == cUser.data.name) {
//                 return FadeTransition(
//                   opacity: animation,
//                   key: Key(task.id!),
//                   child: SizeTransition(
//                     sizeFactor: CurvedAnimation(
//                       parent: animation,
//                       curve: Curves.easeOut,
//                       reverseCurve: Curves.easeIn,
//                     ),
//                     child: AnimatedBuilder(
//                         animation: _controller,
//                         builder: (context, child) => CardRequest(
//                               data: task,
//                               animationColor: _colorAnimation.value,
//                               listImage: task.image!,
//                               listRequest: value.filteredListTasks,
//                             )),
//                   ),
//                 );
//               }
//               return FadeTransition(
//                 opacity: animation,
//                 key: Key(task.id!),
//                 child: SizeTransition(
//                   sizeFactor: CurvedAnimation(
//                     parent: animation,
//                     curve: Curves.easeOut,
//                     reverseCurve: Curves.easeIn,
//                   ),
//                   child: AnimatedBuilder(
//                       animation: _controller,
//                       builder: (context, child) => CardRequest(
//                             data: task,
//                             animationColor: _colorAnimation.value,
//                             listImage: task.image!,
//                             listRequest: value.filteredListTasks,
//                           )),
//                 ),
//               );
//             },
//           );
//         }),
//       ),
//     );
//   }
// }
