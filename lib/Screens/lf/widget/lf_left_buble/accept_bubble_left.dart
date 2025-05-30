import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../homescreen/widget/card_request.dart';

class AcceptedBubbleLeft extends StatelessWidget {
  final String isAccepted;
  final String time;
  const AcceptedBubbleLeft(
      {super.key, required this.isAccepted, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        margin: EdgeInsets.only(right: width * 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Colors.green.shade100)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$isAccepted ${AppLocalizations.of(context)!.hasAcceptThisRequest}",
                  style:
                      TextStyle(color: Colors.black87, fontSize: size * 0.012),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    width: width * 0.07,
                    height: height * 0.04,
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )),
                Text(
                  DateFormat('MMM dd, HH:mm')
                      .format(DateTime.parse(time).toLocal()),
                  style: TextStyle(
                      fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                ),
              ],
            ),
          ],
        ));
  }
}
