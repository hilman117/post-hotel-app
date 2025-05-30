// import 'package:flutter/material.dart';
// import 'package:post/Screens/dasboard/widget/list_of_request.dart';
// import 'package:post/Screens/dasboard/widget/stream.dart';

// class MyPost extends StatefulWidget {
//   final ScrollController controller;
//   const MyPost({Key? key, required this.controller}) : super(key: key);

//   @override
//   _MyPostState createState() => _MyPostState();
// }

// class _MyPostState extends State<MyPost> {
//   StreamWidget stream = StreamWidget();
//   @override
//   Widget build(BuildContext context) {
//     return ListOfRequest(streamMine: stream.myPost(), controller: widget.controller,);
//   }

// // class TextDate extends StatefulWidget {
// //   const TextDate({Key? key, required this.taskModel}) : super(key: key);
// //   final TaskModel taskModel;

// //   @override
// //   State<TextDate> createState() => _TextDateState();
// // }

// // class _TextDateState extends State<TextDate> {
// //   RxString _clock = 'clock here'.obs;
// //   String get clock => _clock.value;
// //   setClock(String n) => _clock.value = n;

// //   late Timer? _timer;

// //   @override
// //   void initState() {
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       setClock(remainingDateTime(widget.taskModel.time!));
// //       print(clock + "-----------");
// //       setState(() {});
// //     });
// //     super.initState();
// //   }

// //   // @override
// //   // void dispose() {
// //   //   if (_timer?.isActive ?? false) {
// //   //     _timer!.cancel();
// //   //   }

// //   //   super.dispose();
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       return Text(
// //         clock,
// //         textAlign: TextAlign.end,
// //         style: TextStyle(fontSize: 12, color: Colors.blue),
// //       );
// //     });
// //   }
// // }
// }
