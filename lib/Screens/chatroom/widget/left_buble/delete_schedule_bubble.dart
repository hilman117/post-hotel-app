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
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: width * 0.2),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              border: Border.all(color: Colors.red.shade100)),
          width: width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width * 0.07,
                      height: height * 0.04,
                      child: const Icon(
                        Icons.free_cancellation_outlined,
                        color: Colors.red,
                      )),
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
          )),
    );
  }
}
