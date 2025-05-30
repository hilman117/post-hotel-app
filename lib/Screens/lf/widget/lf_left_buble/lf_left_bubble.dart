import 'package:flutter/material.dart';

import 'accept_bubble_left.dart';
import 'left_message.dart';

class LfLeftBubble extends StatelessWidget {
  final List<dynamic> commentList;
  final String time;
  final String senderMsgName;
  final String message;
  // String description,
  final String isAccepted;
  final List<dynamic> image;
  const LfLeftBubble(
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
                : LfLeftMessage(
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
            : AcceptedBubbleLeft(time: time, isAccepted: isAccepted),
        SizedBox(
          height: isAccepted.isEmpty || message.isNotEmpty ? 0 : 5,
        ),
      ],
    );
  }
}
