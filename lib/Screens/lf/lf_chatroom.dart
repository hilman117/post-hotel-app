// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/lf/widget/lf_appbar.dart';
import 'package:post_app/Screens/lf/widget/stream_lf_chat.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

class LfChatRoom extends StatefulWidget {
  const LfChatRoom({super.key, 
    required this.taskId,
    required this.hotelid,
    required this.status,
    required this.image,
    required this.nameOfReporter,
    required this.receiver,
    required this.nameOfItemFounded,
    required this.locationItemFounded,
    required this.photoProfileSender,
    required this.positionReporter,
    required this.time,
    required this.emailSender,
  });
  final String taskId;
  final String hotelid;
  final String status;
  final List<String> image;
  final String nameOfReporter;
  final String receiver;
  final String nameOfItemFounded;
  final String locationItemFounded;
  final String photoProfileSender;
  final String positionReporter;
  final String emailSender;
  final DateTime time;

  @override
  _LfChatRoomState createState() => _LfChatRoomState();
}

class _LfChatRoomState extends State<LfChatRoom> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();
  final cUser = Get.put(CUser());

  @override
  void initState() {
    // Future.delayed(
    //   Duration.zero,
    //   () {
    //     Provider.of<ChatRoomController>(context, listen: false).changeStatus(
    //         widget.statusTask,
    //         widget.penerimaTask,
    //         widget.assign.isEmpty ? "" : widget.assign.last);
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.165),
            child: Consumer<ChatRoomController>(
              builder: (context, value, child) {
                return LfAppBar(
                  status: widget.status,
                  image: widget.image,
                  nameOfReporter: widget.nameOfReporter,
                  receiver: widget.receiver,
                  nameOfItemFounded: widget.nameOfItemFounded,
                  locationItemFounded: widget.locationItemFounded,
                  photoProfileSender: widget.photoProfileSender,
                  positionReporter: widget.positionReporter,
                  time: widget.time,
                );
              },
            )),
        body: StreamLfChat(
          taskId: widget.taskId,
          hotelid: widget.hotelid,
          emailSender: widget.emailSender,
          location: widget.locationItemFounded,
          reportCreator: widget.nameOfReporter,
          title: widget.nameOfItemFounded,
        ));
  }
}
