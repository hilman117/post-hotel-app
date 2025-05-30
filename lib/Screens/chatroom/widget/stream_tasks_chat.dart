// ignore_for_file: deprecated_member_use

import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/chatroom/widget/bubble_chat/bubble_chat.dart';
import 'package:post_app/core.dart';
import 'package:post_app/custom/custom_scroll_behavior.dart';
import 'package:provider/provider.dart';

import '../../../controller/c_user.dart';
import '../../../models/chat_model.dart';

// ignore: must_be_immutable
class StreamTasksChat extends StatefulWidget {
  final TaskModel task;

  const StreamTasksChat({super.key, required this.task});

  @override
  State<StreamTasksChat> createState() => _StreamTasksChatState();
}

class _StreamTasksChatState extends State<StreamTasksChat>
    with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  late AnimationController _controller;

  double widht = Get.width;

  double height = Get.height;

  final user = Get.put(CUser());

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        reverseDuration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Expanded(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: fullWidth < maxWidth ? 10.sp : 10,
              vertical: fullWidth < maxWidth ? 10.sp : 10),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Hotel List')
                .doc(user.data.hotel)
                .collection(widget.task.typeReport!)
                .doc(widget.task.id)
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                var commentList = (snapshot.data!["comment"] as List<dynamic>)
                    .map((e) => e as Map<String, dynamic>)
                    .toList();
                List<ChatModel> listChat =
                    commentList.map((e) => ChatModel.fromJson(e)).toList();
                listChat.sort(
                  (a, b) => b.time!.compareTo(a.time!),
                );
                return Consumer<ChatRoomController>(
                    builder: (context, value, child) {
                  return ScrollConfiguration(
                      behavior:
                          NoGlowScrollBehavior().copyWith(overscroll: false),
                      child: AutomaticAnimatedList<ChatModel>(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        controller: value.scrollController,
                        items: listChat,
                        keyingFunction: (ChatModel item) =>
                            Key(item.commentId!),
                        insertDuration: const Duration(milliseconds: 200),
                        removeDuration: const Duration(milliseconds: 200),
                        itemBuilder: (contect, chatModel, animation) {
                          final index = listChat.indexOf(chatModel);
                          return FadeTransition(
                            opacity: animation,
                            key: Key(chatModel.commentId!),
                            child: SizeTransition(
                              sizeFactor: CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                                reverseCurve: Curves.easeIn,
                              ),
                              child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) => bubbleChat(
                                      context: context,
                                      isMe: chatModel.senderemail ==
                                              user.data.email
                                          ? true
                                          : false,
                                      chatModel: chatModel,
                                      listMessage: listChat,
                                      index: index)),
                            ),
                          );
                        },
                      ));
                });
              }
              return const SizedBox(
                child: Center(
                  child: Text("Memuat chat..."),
                ),
              );
            },
          ),
        ));
  }
}
