// import 'package:animated_list_plus/animated_list_plus.dart';
// import 'package:animated_list_plus/transitions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../models/tasks.dart';
// import '../dasboard/widget/card.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget>
//     with SingleTickerProviderStateMixin {
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
//   String textInput = '';

//   late AnimationController _controller;
//   int index = 0;

//   @override
//   void initState() {
//     _controller = AnimationController(
//         duration: const Duration(seconds: 2),
//         vsync: this,
//         reverseDuration: Duration(seconds: 2))
//       ..repeat(reverse: true);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("Hotel List")
//             .doc(cUser.data.hotelid)
//             .collection("tasks")
//             .where("assigned", arrayContains: cUser.data.department)
//             .where("status", isNotEqualTo: "Close")
//             .snapshots(includeMetadataChanges: true),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }
//           if (snapshot.data == null) {
//             return Center(child: Image.asset('images/empty.png', width: 150));
//           }
//           if (snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/empty.png',
//                       width: Get.width * 0.6,
//                     ),
//                     Text(
//                       "All done! no task recently",
//                       style: const TextStyle(color: Colors.grey),
//                     )
//                   ]),
//             );
//           }
//           List<QueryDocumentSnapshot<Object?>> list = snapshot.data!.docs;
//           list.sort((a, b) => b["time"].compareTo(a["time"]));
//           // setiniTotal(snapshot.data!.size);
//           // setincrement(increment + 1);

//           return ImplicitlyAnimatedList(
//             removeItemBuilder: (context, animation, item) {
//               Map<String, dynamic> data =
//                   list[index].data()! as Map<String, dynamic>;
//               TaskModel taskModel = TaskModel.fromJson(data);
//               return FadeTransition(
//                 opacity: CurvedAnimation(
//                     parent: animation, curve: Interval(0.5, 1.0)),
//                 child: SizeTransition(
//                   axisAlignment: 0.0,
//                   sizeFactor: CurvedAnimation(
//                       parent: animation, curve: Interval(0.0, 1.0)),
//                   child: AnimatedBuilder(
//                       animation: _controller,
//                       builder: (BuildContext context, Widget? child) {
//                         return listdata(
//                             data,
//                             taskModel,
//                             bgColor.evaluate(
//                                 AlwaysStoppedAnimation(_controller.value)));
//                       }),
//                 ),
//               );
//             },
//             // updateItemBuilder: (context, animation, item) {
//             //   Map<String, dynamic> data =
//             //       list[index].data()! as Map<String, dynamic>;
//             //   TaskModel taskModel = TaskModel.fromJson(data);
//             //   return FadeTransition(
//             //     opacity: CurvedAnimation(
//             //         parent: animation, curve: Interval(1.0, 0.5)),
//             //     child: SizeTransition(
//             //       axisAlignment: 0.0,
//             //       sizeFactor: CurvedAnimation(
//             //           parent: animation, curve: Interval(1.0, 0.0)),
//             //       child: AnimatedBuilder(
//             //           animation: _controller,
//             //           builder: (BuildContext context, Widget? child) {
//             //             return listdata(
//             //                 data,
//             //                 taskModel,
//             //                 bgColor.evaluate(
//             //                     AlwaysStoppedAnimation(_controller.value)));
//             //           }),
//             //     ),
//             //   );
//             // },
//             items: list,
//             itemBuilder: (context, animation, item, i) {
//               Map<String, dynamic> data =
//                   list[i].data()! as Map<String, dynamic>;
//               TaskModel taskModel = TaskModel.fromJson(data);
//               // print(data);
//               if (textInput.isEmpty && data['status'] == "New") {
//                 return SizeFadeTransition(
//                   animation: animation,
//                   sizeFraction: 0.7,
//                   curve: Interval(0.0, 1.0),
//                   child: AnimatedBuilder(
//                       animation: _controller,
//                       builder: (BuildContext context, Widget? child) {
//                         return listdata(
//                             data,
//                             taskModel,
//                             bgColor.evaluate(
//                                 AlwaysStoppedAnimation(_controller.value)));
//                       }),
//                 );
//               }
//               if (data['location']
//                   .toString()
//                   .toLowerCase()
//                   .contains(textInput.toLowerCase())) {
//                 return SizeFadeTransition(
//                   animation: animation,
//                   sizeFraction: 0.7,
//                   curve: Curves.easeInOut,
//                   child: listdata(
//                       data,
//                       taskModel,
//                       bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value))),
//                 );
//               }
//               if (data['title']
//                   .toString()
//                   .toLowerCase()
//                   .contains(textInput.toLowerCase())) {
//                 return SizeFadeTransition(
//                   animation: animation,
//                   sizeFraction: 0.7,
//                   curve: Curves.easeInOut,
//                   child: listdata(
//                       data,
//                       taskModel,
//                       bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value))),
//                 );
//               }
//               if (data['sender']
//                   .toString()
//                   .toLowerCase()
//                   .contains(textInput.toLowerCase())) {
//                 return SizeFadeTransition(
//                   animation: animation,
//                   sizeFraction: 0.7,
//                   curve: Curves.easeInOut,
//                   child: listdata(
//                       data,
//                       taskModel,
//                       bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value))),
//                 );
//               }
//               return Container();
//             },
//             areItemsTheSame: (a, b) => a == b,
//           );
//           // return ListView.builder(
//           //     padding: EdgeInsets.all(0),
//           //     itemCount: list.length,
//           //     itemBuilder: (BuildContext context, int index) {
//           //       Map<String, dynamic> data =
//           //           list[index].data()! as Map<String, dynamic>;
//           //       TaskModel taskModel = TaskModel.fromJson(data);
//           //       // print(data);
//           //       if (textInput.isEmpty && data['status'] == "New") {
//           //         return AnimatedBuilder(
//           //             animation: _controller,
//           //             builder: (BuildContext context, Widget? child) {
//           //               return listdata(
//           //                   data,
//           //                   taskModel,
//           //                   bgColor.evaluate(
//           //                       AlwaysStoppedAnimation(_controller.value)));
//           //             });
//           //       }
//           //       if (data['location']
//           //           .toString()
//           //           .toLowerCase()
//           //           .contains(textInput.toLowerCase())) {
//           //         return listdata(
//           //             data,
//           //             taskModel,
//           //             bgColor.evaluate(
//           //                 AlwaysStoppedAnimation(_controller.value)));
//           //       }
//           //       if (data['title']
//           //           .toString()
//           //           .toLowerCase()
//           //           .contains(textInput.toLowerCase())) {
//           //         return listdata(
//           //             data,
//           //             taskModel,
//           //             bgColor.evaluate(
//           //                 AlwaysStoppedAnimation(_controller.value)));
//           //       }
//           //       if (data['sender']
//           //           .toString()
//           //           .toLowerCase()
//           //           .contains(textInput.toLowerCase())) {
//           //         return listdata(
//           //             data,
//           //             taskModel,
//           //             bgColor.evaluate(
//           //                 AlwaysStoppedAnimation(_controller.value)));
//           //       }
//           //       return Container();
//           //     });
//         },
//       ),
//     );
//   }
// }
