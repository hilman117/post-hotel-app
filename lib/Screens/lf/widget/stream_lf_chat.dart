import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/lf/lf_controller.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';
import '../../sign_up/signup.dart';
import '../../chatroom/chatroom_controller.dart';
import 'lf_keyboard.dart';
import 'lf_left_buble/lf_left_bubble.dart';
import 'lf_right_bubble/lf_right_bubble.dart';
import 'list_images_comment.dart';

// ignore: must_be_immutable
class StreamLfChat extends StatelessWidget {
  final scrollController = ScrollController();
  final String taskId;
  final String hotelid;
  final String emailSender;
  final String reportCreator;
  final String title;
  final String location;

  double widht = Get.width;
  double height = Get.height;

  StreamLfChat({
    super.key,
    required this.taskId,
    required this.hotelid,
    required this.emailSender,
    required this.reportCreator,
    required this.title,
    required this.location,
  });

  final user = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Hotel List')
                  .doc(user.data.hotelid)
                  .collection('lost and found')
                  .doc(taskId)
                  .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var commentList = (snapshot.data!.data()
                      as Map<String, dynamic>)['comment'] as List;
                  commentList
                      .sort((a, b) => b['timeSent'].compareTo(a['timeSent']));
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(0),
                    controller: scrollController,
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          snapshot.data!['comment'][index]['senderemail'] ==
                                  auth.currentUser!.email
                              ? LfRightBubble(
                                  commentList: commentList,
                                  time: commentList[index]['time'],
                                  senderMsgName: commentList[index]['sender'],
                                  isAccepted: commentList[index]['accepted'],
                                  image: commentList[index]['imageComment'],
                                  message: commentList[index]['commentBody'])
                              : LfLeftBubble(
                                  commentList: commentList,
                                  time: commentList[index]['time'],
                                  senderMsgName: commentList[index]['sender'],
                                  isAccepted: commentList[index]['accepted'],
                                  image: commentList[index]['imageComment'],
                                  message: commentList[index]['commentBody']),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          )),
          SizedBox(
            // height: height * 0.15,
            width: widht,
            child: Consumer<ReportLFController>(
              builder: (context, value, child) => AnimatedSwitcher(
                switchInCurve: Curves.easeInSine,
                switchOutCurve: Curves.easeOutSine,
                duration: const Duration(seconds: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: lfKeyboardChatroom(
                          context: context,
                          creatorEmail: emailSender,
                          location: location,
                          reportCreator: reportCreator,
                          scroll: scrollController,
                          taskId: taskId,
                          title: title),
                    ),
                    value.imagesList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   height: height * 0.06,
                                //   width: widht * 0.6,
                                //   child: Image.file(
                                //     value.images!,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                Positioned(
                                    left: 30,
                                    bottom: 15,
                                    child: CloseButton(
                                      color: Colors.grey,
                                      onPressed: () {
                                        provider.clearImage();
                                      },
                                    )),
                                value.imagesList.isNotEmpty
                                    ? const ListImagesComment()
                                    : const SizedBox()
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
