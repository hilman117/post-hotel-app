import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../models/chat_model.dart';
import 'widget/action_bubble.dart';
import 'widget/message/message_widget.dart';

Widget bubbleChat(
    {required BuildContext context,
    required bool isMe,
    // required BoxConstraints p2,
    required ChatModel chatModel,
    required List<ChatModel> listMessage,
    required int index}) {
  // DateTime convertedTimeStampToDatetime =
  //     DateTime.parse(chatModel.time!.toDate().toString());
  var dateChat = DateFormat("MMM d, ''yy'").format(chatModel.time!);
  bool isVisible = false;
  if (listMessage.length - 1 == index) {
    isVisible = true;
  } else {
    var previousChat = listMessage[index + 1];
    var currentChat = listMessage[index];
    var previousTime = DateFormat("MMM d, ''yy'").format(previousChat.time!);
    var currentTime = DateFormat("MMM d, ''yy'").format(currentChat.time!);
    if (currentTime != previousTime) {
      isVisible = true;
    }
  }
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  return Column(
    children: [
      if (isVisible)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: fullWidth < maxWidth ? 10.w : 10),
              child: Text(
                dateChat,
                style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 11.sp : 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      (chatModel.commentBody != "" ||
              chatModel.description != "" ||
              chatModel.imageComment!.isNotEmpty &&
                  chatModel.accepted == "" &&
                  chatModel.assignTask == "" &&
                  chatModel.hold == "" &&
                  chatModel.newlocation == "" &&
                  chatModel.scheduleDelete == "" &&
                  chatModel.setDate == "" &&
                  chatModel.titleChange == "" &&
                  chatModel.resume == "")
          ? messageWidget(
              context: context,
              isMe: isMe,
              chatModel: chatModel,
              listMessage: listMessage,
              index: index,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted != "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage:
                  "${chatModel.sender} ${AppLocalizations.of(context)!.hasAcceptThisRequest}",
              icons: CupertinoIcons.checkmark_alt_circle_fill,
              iconColor: Colors.green,
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTo != "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage:
                  "${chatModel.sender} ${AppLocalizations.of(context)!.hasAssignThisRequestTo} ${chatModel.assignTo}",
              icons: CupertinoIcons.group_solid,
              iconColor: const Color(0xff0071B1),
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold != "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage:
                  "${chatModel.hold!} ${AppLocalizations.of(context)!.onHold} ${AppLocalizations.of(context)!.request} ",
              icons: Icons.pause,
              iconColor: Colors.grey,
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation != "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage: chatModel.newlocation!,
              icons: Icons.edit_location_alt,
              iconColor: Colors.blue,
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete != "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage: chatModel.scheduleDelete!,
              icons: Icons.delete_outlined,
              iconColor: Colors.red,
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate != "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage: chatModel.setDate!,
              icons: Icons.schedule_outlined,
              iconColor: Colors.blue,
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange != "" &&
              chatModel.resume == "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage: chatModel.titleChange!,
              icons: Icons.edit,
              iconColor: Colors.grey,
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume != "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage:
                  "${chatModel.resume!} ${AppLocalizations.of(context)!.resume} ${AppLocalizations.of(context)!.request} ",
              icons: Icons.play_arrow_rounded,
              iconColor: const Color(0xff0071B1),
              chatModel: chatModel,
            )
          : const SizedBox(),
      (chatModel.commentBody == "" &&
              chatModel.description == "" &&
              chatModel.imageComment!.isEmpty &&
              chatModel.accepted == "" &&
              chatModel.assignTask == "" &&
              chatModel.hold == "" &&
              chatModel.newlocation == "" &&
              chatModel.scheduleDelete == "" &&
              chatModel.setDate == "" &&
              chatModel.titleChange == "" &&
              chatModel.resume == "" &&
              chatModel.esc != "")
          ? actionBubble(
              context: context,
              time: chatModel.time!.toLocal().toString(),
              actionMessage:
                  "${AppLocalizations.of(context)!.request} ${AppLocalizations.of(context)!.escalation} after ${chatModel.esc} minutes",
              icons: CupertinoIcons.stopwatch,
              iconColor: const Color(0xff0071B1),
              chatModel: chatModel,
            )
          : const SizedBox(),
    ],
  );
}
