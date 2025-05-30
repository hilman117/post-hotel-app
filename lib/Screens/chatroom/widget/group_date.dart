import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupDate extends StatelessWidget {
  const GroupDate({
    super.key,
    required this.time,
  });

  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      // height: 20,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.shade100),
          padding: const EdgeInsets.all(5),
          child: Text(
            groupChatPerDate(time),
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          )),
    );
  }
}

String groupChatPerDate(Timestamp date) {
  int dateOfGroup = date.toDate().day;
  int today = DateTime.now().day;
  // int yesterday = DateTime.now().day - 1;
  if (dateOfGroup == today) {
    return "Today";
  }
  if (dateOfGroup + 1 == today ||
      dateOfGroup ==
              DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day &&
          today == 1) {
    return "Yesterday";
  }
  return DateFormat("dd/MM/yy").format(date.toDate());
}
