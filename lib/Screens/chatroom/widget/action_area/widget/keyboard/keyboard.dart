import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/chatroom/widget/action_area/widget/keyboard/widget/send_more_button.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'widget/texfield.dart';

final user = Get.put(CUser());

Widget keyboardChat({
  required BuildContext context,
  required ScrollController scroll,
  required TaskModel task,
  required String oldTime,
  required String oldDate,
}) {
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;

  return SizedBox(
    // height: MediaQuery.of(context).orientation == Orientation.landscape
    //     ? height * 0.08
    //     : height * 0.05,
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: fullWidth < maxWidth ? 10.w : 10,
        ),
        // ignore: prefer_const_constructors
        TextFieldArea(),
        SendAndMoreButton(
          oldTime: oldTime,
          oldDate: oldDate,
          scroll: scroll,
          task: task,
        ),
      ],
    ),
  );
}
