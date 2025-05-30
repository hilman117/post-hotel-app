import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/controller/c_user.dart';

import '../../../../../models/chat_model.dart';

Widget actionBubble(
    {required BuildContext context,
    required String time,
    required String actionMessage,
    required IconData icons,
    required Color iconColor,
    required ChatModel chatModel}) {
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  final theme = Theme.of(context);
  final user = Get.put(CUser());
  bool isMe = chatModel.sender == user.data.name;
  return Builder(builder: (context) {
    if (isMe == true) {
      return Container(
        alignment: Alignment.center,
        // padding: EdgeInsets.all(5.sp),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        width: fullWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: fullWidth < maxWidth ? 40.sp : 40,
              child: Text(
                DateFormat.Hm().format(DateTime.parse(time.toLowerCase())),
                style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: fullWidth < maxWidth ? 10.sp : 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: SelectableText(
                  actionMessage,
                  style: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: fullWidth < maxWidth ? 14.sp : 14,
                      fontWeight: FontWeight.w500,
                      color: theme.focusColor),
                  // overflow: TextOverflow.clip,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Icon(
              icons,
              color: iconColor,
              size: 35.w,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.all(5.sp),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      width: fullWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10.w),
          Icon(
            icons,
            color: iconColor,
            size: 35.sp,
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              // margin: EdgeInsets.symmetric(
              //     horizontal: fullWidth < maxWidth ? 10.sp : 10),
              child: SelectableText(
                actionMessage,
                style: TextStyle(
                    letterSpacing: -0.5,
                    fontSize: fullWidth < maxWidth ? 14.sp : 14,
                    fontWeight: FontWeight.w500,
                    color: theme.focusColor),
                // overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: fullWidth < maxWidth ? 40.sp : 40,
            child: Text(
              DateFormat.Hm().format(DateTime.parse(time.toLowerCase())),
              style: TextStyle(
                  letterSpacing: -0.5,
                  fontSize: fullWidth < maxWidth ? 10.sp : 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          )
        ],
      ),
    );
  });
}
