import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../homescreen/widget/card_request.dart';

class Resume extends StatelessWidget {
  final String resume;
  final String time;
  const Resume({super.key, required this.resume, required this.time});

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
              border: Border.all(color: Colors.green.shade100)),
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
                        Icons.play_arrow,
                        color: Colors.green,
                      )),
                  Container(
                    width: width * 0.63,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      countryCode == const Locale("en")
                          ? DateFormat('MMM, dd hh:mm a')
                              .format(DateTime.parse(time).toLocal())
                          : DateFormat('MMM, dd HH:mm')
                              .format(DateTime.parse(time).toLocal()),
                      style: TextStyle(
                          color: Colors.black87, fontSize: size * 0.012),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('EE d, HH:mm').format(DateTime.parse(time)),
                style: TextStyle(
                    fontSize: size * 0.01, color: Colors.grey, height: 1.5),
              ),
            ],
          )),
    );
  }
}
