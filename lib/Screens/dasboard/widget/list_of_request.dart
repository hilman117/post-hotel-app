// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:post/service/notif.dart';
// import 'package:provider/provider.dart';
// import '../../../controller/c_new.dart';
// import '../../../controller/c_user.dart';
// import '../../../models/tasks.dart';
// import '../../homescreen/home_controller.dart';

// class ListOfRequest extends StatefulWidget {
//   const ListOfRequest({
//     Key? key,
//     required this.streamMine,
//     required this.controller,
//   }) : super(key: key);
//   final Stream<QuerySnapshot<Map<String, dynamic>>> streamMine;
//   final ScrollController controller;

//   @override
//   State<ListOfRequest> createState() => _ListOfRequestState();
// }

// class _ListOfRequestState extends State<ListOfRequest>
//     with SingleTickerProviderStateMixin {
//   FirebaseAuth auth = FirebaseAuth.instance;
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
//   TextEditingController searchController = TextEditingController();
//   // final GlobalKey<AnimatedListState> _listKey = GlobalKey();
//   bool isSearch = true;

//   Timer? everyMinutes;

//   changed() {
//     cNew.setData(true);
//     Future.delayed(
//       Duration(seconds: 2),
//       () {
//         cNew.setData(false);
//       },
//     );
//   }

//   // late File _image;
//   String imageName = '';
//   String imageUrl = "";

//   String taskId = '';
//   String topicEsc = '';
//   String location1 = '';
//   String titel1 = '';
//   String status1 = '';
//   DateTime? waktu;
//   int jarakWaktu2 = 0;
//   @override
//   void initState() {
//     _controller = AnimationController(
//         duration: const Duration(seconds: 2),
//         vsync: this,
//         reverseDuration: Duration(seconds: 2))
//       ..repeat(reverse: true);
//     Timer.periodic(Duration(minutes: 1), (Timer timer) {
//       if (mounted) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // ignore: non_constant_identifier_names
//   final cUser = Get.put(CUser());
//   final cNew = Get.put(Cnew());
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   RxInt _iniTotal = 0.obs;
//   setiniTotal(n) => _iniTotal.value = n;
//   int get initotal => _iniTotal.value;
//   int data1 = 0;
//   int data2 = 0;

//   RxInt _increment = 0.obs;
//   setincrement(n) {
//     _controller
//         .animateTo(1.0)
//         .then<TickerFuture>((value) => _controller.animateBack(0.0));

//     _increment.value = n;
//     if (n == 1) {
//       data1 = initotal;
//     } else if (n == 2) {
//       data2 = initotal;
//     }
//     if (data1 != data2) {
//       cNew.setData(true);
//       Future.delayed(
//         Duration(seconds: 2),
//         () {
//           // print("--------------------------");
//           // print(cNew.data);
//           cNew.setData(false);
//           // print(cNew.data);
//         },
//       );
//     }
//   }

//   int get increment => _increment.value;

//   String? acceptedby;
//   String time = '';

//   String? idpenerima;
//   String sender = " ";

//   @override
//   Widget build(BuildContext context) {
//     final list = Provider.of<List<TaskModel>>(context, listen: false);
//     return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         body: GlowingOverscrollIndicator(
//           color: Colors.white.withOpacity(0.0),
//           axisDirection: AxisDirection.down,
//           child: ListView.builder(
//               controller: widget.controller,
//               padding: EdgeInsets.only(top: 5),
//               itemCount: list.length,
//               itemBuilder: (BuildContext context, int index) {
//                 list.sort((a, b) => b.time!.compareTo(a.time!));
//                 TaskModel data = list[index];
//                 Notif().saveTopic(data.id!);
//                 // print(data);
//                 List assigned = data.assigned!;
//                 // print(assigned);
//                 if (Provider.of<HomeController>(context).textInput.isEmpty &&
//                         data.status == "New" ||
//                     assigned
//                         .toString()
//                         .toLowerCase()
//                         .contains(cUser.data.name!)) {
//                   return AnimatedBuilder(
//                       animation: _controller,
//                       builder: (BuildContext context, Widget? child) {
//                         return CardList(
//                             data: data,
//                             animationColor: bgColor.evaluate(
//                                 AlwaysStoppedAnimation(_controller.value)),
//                             listImage: data.image!,
//                             list: list);
//                       });
//                 }
//                 if (data.location.toString().toLowerCase().contains(
//                     Provider.of<HomeController>(context)
//                         .textInput
//                         .toLowerCase())) {
//                   return CardList(
//                       data: data,
//                       animationColor: bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value)),
//                       listImage: data.image!,
//                       list: list);
//                 }
//                 if (data.title.toString().toLowerCase().contains(
//                     Provider.of<HomeController>(context)
//                         .textInput
//                         .toLowerCase())) {
//                   return CardList(
//                       data: data,
//                       animationColor: bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value)),
//                       listImage: data.image!,
//                       list: list);
//                 }
//                 if (data.sender.toString().toLowerCase().contains(
//                     Provider.of<HomeController>(context)
//                         .textInput
//                         .toLowerCase())) {
//                   return CardList(
//                       data: data,
//                       animationColor: bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value)),
//                       listImage: data.image!,
//                       list: list);
//                 }
//                 if (data.assigned
//                     .toString()
//                     .toLowerCase()
//                     .contains(cUser.data.name!.toLowerCase())) {
//                   return CardList(
//                       data: data,
//                       animationColor: bgColor
//                           .evaluate(AlwaysStoppedAnimation(_controller.value)),
//                       listImage: data.image!,
//                       list: list);
//                 }
//                 return Center();
//               }),
//         ));
//   }
// }
