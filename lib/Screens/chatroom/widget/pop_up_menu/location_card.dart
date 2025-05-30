import 'package:flutter/material.dart';
import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:provider/provider.dart';

Widget locationCard(BuildContext context, int index, String tasksId,
    String emailSender, String oldLocation) {
  return InkWell(
    onTap: () {
      Provider.of<PopUpMenuProvider>(context, listen: false)
          .storeNewLocation(context, tasksId, oldLocation, emailSender, "");
    },
    child: Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 0.5, color: Colors.grey.shade300))),
      child: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "provider.data[index]",
          style: TextStyle(fontWeight: FontWeight.w300),
          overflow: TextOverflow.clip,
        ),
      ),
    ),
  );
}
