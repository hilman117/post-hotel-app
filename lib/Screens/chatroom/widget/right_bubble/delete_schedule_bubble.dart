import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../homescreen/widget/card_request.dart';

class DeleteScheduleBubble extends StatelessWidget {
  final String deleteSchedule;
  final String time;
  const DeleteScheduleBubble(
      {super.key, required this.deleteSchedule, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    Locale countryCode = Localizations.localeOf(context);

    return Container(
        margin: EdgeInsets.only(left: width * 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Colors.red.shade100)),
        width: width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.63,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "$deleteSchedule has removed the schedule",
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.012),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                    width: width * 0.07,
                    height: height * 0.04,
                    child: const Icon(
                      Icons.free_cancellation_outlined,
                      color: Colors.red,
                    )),
              ],
            ),
            Text(
              countryCode == const Locale("en")
                  ? DateFormat('MMM, dd hh:mm a')
                      .format(DateTime.parse(time).toLocal())
                  : DateFormat('MMM, dd HH:mm')
                      .format(DateTime.parse(time).toLocal()),
              style: TextStyle(
                  fontSize: size * 0.01, color: Colors.grey, height: 1.5),
            ),
          ],
        ));
  }
}
