import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/l10n/app_localizations.dart';

import '../../../homescreen/widget/card_request.dart';

class AcceptedBubbleRight extends StatelessWidget {
  final String isAccepted;
  final String time;
  const AcceptedBubbleRight(
      {super.key, required this.isAccepted, required this.time});

  @override
  Widget build(BuildContext context) {
    double size = Get.width + Get.height;
    return Container(
        margin: EdgeInsets.only(left: width * 0.2),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(color: Colors.green.shade100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: width * 0.07,
                    height: height * 0.04,
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: size * 0.01, color: Colors.grey, height: 1.5),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(
                    "$isAccepted ${AppLocalizations.of(context)!.hasAcceptThisRequest}",
                    style: TextStyle(
                        color: Colors.black87, fontSize: size * 0.012),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
