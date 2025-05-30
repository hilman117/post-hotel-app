// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/Screens/ios_view/ios_action_area.dart';
import 'package:post_app/common_widget/status.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:provider/provider.dart';

import '../../global_function.dart';
import '../chatroom/widget/stream_tasks_chat.dart';

class IosChatRoom extends StatefulWidget {
  const IosChatRoom({
    super.key,
    required this.taskModel,
    required this.isTask,
    required this.isWithKeyboard,
  });
  // final int jarakWaktu;
  final TaskModel taskModel;
  final bool isTask;
  final bool isWithKeyboard;
  // final String image;

  @override
  _IosChatRoomState createState() => _IosChatRoomState();
}

class _IosChatRoomState extends State<IosChatRoom> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();
  final cUser = Get.put(CUser());
  String? schedule;
  FocusNode keyboardFocus = FocusNode();

  String? convertDateToString() {
    String? date;
    String? time;
    if (widget.taskModel.setDate!.isNotEmpty &&
        widget.taskModel.setTime!.isNotEmpty) {
      time = DateFormat("HH:mm")
          .format(DateTime.parse(widget.taskModel.setTime!).toLocal());
      date = DateFormat("EEE, dd MMMM")
          .format(DateTime.parse(widget.taskModel.setDate!).toLocal());
      return "$date $time";
    }
    if (widget.taskModel.setDate!.isEmpty &&
        widget.taskModel.setTime!.isNotEmpty) {
      time = DateFormat("HH:mm")
          .format(DateTime.parse(widget.taskModel.setTime!).toLocal());
      return time;
    }
    return '';
  }

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<CreateRequestController>(context, listen: false)
            .changeDate(widget.taskModel.setDate.toString());
        Provider.of<CreateRequestController>(context, listen: false)
            .changeTime(widget.taskModel.setTime.toString());
        Provider.of<PopUpMenuProvider>(context, listen: false)
            .changelocation(widget.taskModel.location!);
        Provider.of<ChatRoomController>(context, listen: false).changeStatus(
            widget.taskModel.status!,
            widget.taskModel.receiver!,
            widget.taskModel.assigned!.isEmpty
                ? ""
                : widget.taskModel.assigned!.last);
      },
    );

    schedule = convertDateToString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, // ini penting agar bisa menangkap tap di area kosong
      onTap: () => FocusScope.of(context).unfocus(),
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            trailing:
                Consumer<ChatRoomController>(builder: (context, value, child) {
              return SizedBox(
                width: 80.w,
                height: 20.h,
                child: StatusWidget(
                    status: value.status,
                    isFading: false,
                    height: 30.h,
                    fontSize: 10.sp),
              );
            }),
            backgroundColor: theme.cardColor,
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isTask)
                      Image.network(
                        widget.taskModel.iconDepartement!,
                        width: fullWidth < maxWidth ? 30.sp : 30,
                        height: fullWidth < maxWidth ? 30.sp : 30,
                        // errorBuilder: (context, error, stackTrace) => ,
                      )
                  ],
                ),
                if (widget.isTask)
                  SizedBox(
                    width: fullWidth < maxWidth ? 5.sp : 5,
                  ),
                SizedBox(
                  height: fullWidth < maxWidth ? 50.h : 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        // height: fullWidth < maxWidth ? 20.h : 20,
                        // width: fullWidth < maxWidth ? 1150.w : 400,/
                        child: Text(
                          widget.taskModel.title!,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 12.sp : 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                              color: theme.focusColor),
                        ),
                      ),
                      Text(
                        widget.taskModel.location!,
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 12.sp : 12,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.5,
                            color: theme.focusColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Column(
                children: [
                  if (Platform.isAndroid) SizedBox(height: 5.h),
                  if (schedule!.isNotEmpty)
                    Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(top: 5),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Animate(
                        effects: const [
                          FadeEffect(delay: Duration(milliseconds: 300)),
                          SlideEffect(delay: Duration(milliseconds: 300))
                        ],
                        child: Text(
                          "Due $schedule",
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 14.sp : 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing: -0.5,
                              color: Colors.red),
                        ),
                      ),
                    ),
                  StreamTasksChat(
                    task: widget.taskModel,
                  ),
                  if (widget.isWithKeyboard)
                    IosActionArea(
                      task: widget.taskModel,
                      isTask: widget.isTask,
                      keyboardFocus: keyboardFocus,
                    )
                ],
              ),
            ),
          )),
    );
  }
}
