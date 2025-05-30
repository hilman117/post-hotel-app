import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

Widget titleTile(BuildContext context, int index, String title, String tasksId,
    String emailSender) {
  final theme = Theme.of(context);
  final event = Provider.of<CreateRequestController>(context, listen: false);
  return InkWell(
    onTap: () {
      // event.selectTitle(context, title);
    },
    child: Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 0.5, color: Colors.grey.shade300))),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Text(
          title,
          style:
              TextStyle(fontWeight: FontWeight.w300, color: theme.focusColor),
          overflow: TextOverflow.clip,
        ),
      ),
    ),
  );
}
