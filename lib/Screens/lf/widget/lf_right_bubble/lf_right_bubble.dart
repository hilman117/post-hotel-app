import 'package:flutter/material.dart';
import 'package:post_app/Screens/chatroom/widget/right_bubble/accepted_bubble.dart';
import 'package:post_app/Screens/lf/widget/lf_right_bubble/my_message.dart';

class LfRightBubble extends StatelessWidget {
  final List<dynamic> commentList;
  final String time;
  final String senderMsgName;
  final String message;
  // String description,
  final String isAccepted;
  final List<dynamic> image;
  const LfRightBubble(
      {super.key,
      required this.commentList,
      required this.time,
      required this.senderMsgName,
      required this.isAccepted,
      required this.image,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      //buble chat yg tampil jika ada kita sbg pengirim pesan..................................
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        (isAccepted != '')
            ? const SizedBox()
            : (message.isEmpty && image.isEmpty)
                ? const SizedBox()
                : LfMyMessage(
                    commentList: commentList,
                    time: time,
                    message: message,
                    image: image,
                    senderMsgName: senderMsgName),
        //bubble ketika kita menerima task...
        SizedBox(
          height: isAccepted.isEmpty || message.isNotEmpty ? 0 : 5,
        ),
        (isAccepted == '')
            ? const SizedBox()
            : AcceptedBubbleRight(time: time, isAccepted: isAccepted),
        SizedBox(
          height: isAccepted.isEmpty || message.isNotEmpty ? 0 : 5,
        ),
      ],
    );
  }
}
