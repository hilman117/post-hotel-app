// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/common_widget/status.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:provider/provider.dart';
import '../../global_function.dart';
import '../../service/theme.dart';
import 'widget/action_area/action_area.dart';
import 'widget/stream_tasks_chat.dart';
import 'widget/chatroom_appbar/task_appbar.dart';

class ChatRoomTask extends StatefulWidget {
  const ChatRoomTask({
    super.key,
    required this.taskModel,
  });
  // final int jarakWaktu;
  final TaskModel taskModel;
  // final String image;

  @override
  _ChatRoomTaskState createState() => _ChatRoomTaskState();
}

class _ChatRoomTaskState extends State<ChatRoomTask> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();
  final cUser = Get.put(CUser());
  String? schedule;

  String? convertDateToString() {
    String? date;
    if (widget.taskModel.setDate!.isNotEmpty ||
        widget.taskModel.setTime!.isNotEmpty) {
      date = DateFormat("EEE, dd MMMM")
          .format(DateTime.parse(widget.taskModel.setDate!));
      return "$date ${widget.taskModel.setTime!}";
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
    final applications = AppLocalizations.of(context);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Get.back();
        }
      },
      child: Scaffold(
          appBar: Platform.isIOS
              ? AppBar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  shadowColor: Colors.grey,
                  elevation: 1,
                  leadingWidth: fullWidth < maxWidth ? 64.sp : 70,
                  actions: [
                    Consumer<ChatRoomController>(
                        builder: (context, value, child) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            StatusWidget(
                              status: value.status,
                              isFading: false,
                              height: fullWidth < maxWidth ? 1.h : 1,
                              fontSize: fullWidth < maxWidth ? 11.sp : 11,
                            ),
                            (value.status != 'Assigned')
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: fullWidth < maxWidth ? 5.h : 5),
                                    width: fullWidth < maxWidth ? 100.w : 200,
                                    child: value.receiver != ''
                                        ? Text(
                                            value.status != 'Assigned'
                                                ? "${applications!.by} ${value.receiver}"
                                                : "${applications!.to} ${value.assignTo}",
                                            style: TextStyle(
                                                color: secondary,
                                                fontSize: fullWidth < maxWidth
                                                    ? 11.sp
                                                    : 11),
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.end,
                                          )
                                        : SizedBox(
                                            height:
                                                fullWidth < maxWidth ? 5.h : 5),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: fullWidth < maxWidth ? 5.sp : 5),
                                    width: fullWidth < maxWidth ? 100.w : 200,
                                    child: value.status == 'Assigned'
                                        ? Text(
                                            "${applications!.to} ${value.assignTo}",
                                            style: TextStyle(
                                                color: secondary,
                                                fontSize: fullWidth < maxWidth
                                                    ? 11.sp
                                                    : 11),
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.end,
                                          )
                                        : const SizedBox(),
                                  ),
                          ],
                        ),
                      );
                    })
                  ],
                  leading: IconButton(
                      splashRadius: fullWidth < maxWidth ? 20.r : 20,
                      onPressed: () => Get.back(),
                      icon: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: theme.primaryColor,
                            size: fullWidth < maxWidth ? 20.sp : 20,
                          ),
                          CircleAvatar(
                            radius: fullWidth < maxWidth ? 15.r : 15,
                            backgroundColor: Colors.grey,
                            child: Hero(
                                tag: widget.taskModel.id!,
                                child: Image.asset(
                                    widget.taskModel.iconDepartement!)),
                          )
                        ],
                      )),
                  centerTitle: false,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: fullWidth < maxWidth ? 20.h : 20,
                        width: fullWidth < maxWidth ? 250.w : 400,
                        child: Text(
                          widget.taskModel.title!,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 16.sp : 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                              color: theme.focusColor),
                        ),
                      ),
                      Text(
                        widget.taskModel.location!,
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 14.sp : 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.5,
                            color: theme.focusColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.taskModel.sender!,
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 14.sp : 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.5,
                            color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: fullWidth < maxWidth ? 5.h : 5,
                      )
                    ],
                  ),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                if (Platform.isAndroid)
                  Consumer<ChatRoomController>(
                    builder: (context, value, child) {
                      return TaskAppBar(
                        taskmodel: widget.taskModel,
                      );
                    },
                  ),
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
                ActionArea(
                  scrollController: scrollController,
                  task: widget.taskModel,
                )
              ],
            ),
          )),
    );
  }
}
