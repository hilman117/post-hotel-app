import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/chat_model.dart';
import 'widget/multiple_photos.dart';

Widget messageWidget(
    {required BuildContext context,
    required bool isMe,
    required int index,
    required ChatModel chatModel,
    required List<ChatModel> listMessage}) {
  // DateTime convertedTimeStampToDatetime = chatModel.time!.toDate();
  var color = int.parse(chatModel.colorUser!);
  final theme = Theme.of(context);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  Widget bubble = Consumer<ChatRoomController>(
      builder: (context, value, child) => Container(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            width: fullWidth < maxWidth ? 270.w : 400,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: fullWidth < maxWidth ? 10.w : 10,
                  vertical: fullWidth < maxWidth ? 10.h : 10),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(fullWidth < maxWidth ? 16.r : 16),
                  color: value.getBubbleColor(theme, color, isMe)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    chatModel.sender!,
                    style: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: fullWidth < maxWidth ? 14.sp : 14,
                      color: isMe ? theme.focusColor : Color(color),
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  chatModel.commentBody != ""
                      ? SelectableText(
                          chatModel.commentBody!,
                          style: TextStyle(
                            letterSpacing: -0.5,
                            fontSize: fullWidth < maxWidth ? 14.sp : 14,
                            color: theme.focusColor,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.clip,
                          ),
                        )
                      : const SizedBox(),
                  chatModel.description != ""
                      ? SelectableText(
                          chatModel.description!,
                          style: TextStyle(
                            letterSpacing: -0.5,
                            fontSize: fullWidth < maxWidth ? 14.sp : 14,
                            color: theme.focusColor,
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : const SizedBox(),
                  chatModel.imageComment!.isEmpty
                      ? const SizedBox()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: fullWidth < maxWidth ? 10.sp : 10),
                          // height: 300.h,
                          width: fullWidth < maxWidth ? 300.w : 400,
                          child: MultiplePhoto(
                              images: chatModel.imageComment!,
                              moreThan4: fullWidth < maxWidth ? 100.w : 100,
                              isEqualorLessThan1:
                                  fullWidth < maxWidth ? 300.w : 300,
                              listMessages: listMessage))
                ],
              ),
            ),
          ));
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: fullWidth < maxWidth ? 10.w : 10,
        vertical: fullWidth < maxWidth ? 5.h : 5),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isMe
            ? Text(
                DateFormat.Hm().format(chatModel.time!.toLocal()),
                style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: fullWidth < maxWidth ? 10.sp : 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              )
            : bubble,
        const Spacer(),
        isMe
            ? bubble
            : Text(
                DateFormat.Hm().format(chatModel.time!.toLocal()),
                style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: fullWidth < maxWidth ? 10.sp : 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              )
      ],
    ),
  );
}

Color chatColor(BuildContext context, ThemeMode theme, bool isMe, int color) {
  final tema = Theme.of(context);
  if (theme == ThemeMode.dark) {
    return tema.cardColor;
  } else if (theme == ThemeMode.light && isMe) {
    return Colors.blue.shade50;
  } else if (!isMe) {
    return Color(color);
  }
  return Colors.blue.shade50;
}
