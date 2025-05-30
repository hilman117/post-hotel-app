import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../chatroom_controller.dart';

Widget listOfEmployee(
    BuildContext context, String name, String email, int index) {
  final theme = Theme.of(context);
  return StatefulBuilder(
    builder: (context, setState) => Container(
      // margin: EdgeInsets.symmetric(horizontal: 5.sp),
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.white),
              top: BorderSide(width: 0.5, color: Colors.white))),
      child: Consumer<ChatRoomController>(
          builder: (context, value, child) => SwitchListTile(
                title: Text(
                  name,
                  style: TextStyle(
                      color: value.statusDutyList[index] == true
                          ? theme.focusColor
                          : Colors.red,
                      fontSize: 13.sp),
                ),
                activeColor: Colors.blue,
                activeTrackColor: const Color(0xff007dff),
                inactiveTrackColor: Colors.grey,
                onChanged: (value) {
                  Provider.of<ChatRoomController>(context, listen: false)
                      .selectFucntionEmployee(value, index);
                },
                value: value.boolLlistemployee![index],
              )),
    ),
  );
}
