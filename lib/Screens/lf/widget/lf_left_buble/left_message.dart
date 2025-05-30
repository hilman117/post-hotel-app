import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../chatroom/widget/multiple_photos.dart';
import '../../../homescreen/widget/card_request.dart';

class LfLeftMessage extends StatelessWidget {
  final List<dynamic> commentList;
  final String senderMsgName;
  final String time;
  final String message;
  // final String description;
  final List<dynamic> image;
  const LfLeftMessage(
      {super.key, required this.commentList,
      required this.time,
      required this.message,
      // required this.description,
      required this.image,
      required this.senderMsgName});
  @override
  Widget build(BuildContext context) {
    Color finalCOlor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)].shade900;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  right: Get.width * 0.1,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: finalCOlor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          senderMsgName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: finalCOlor),
                        ),
                        SizedBox(
                          height: Get.height * 0.009,
                        ),
                        message.isNotEmpty
                            ? Text(
                                message,
                                style: const TextStyle(color: Colors.black87),
                                overflow: TextOverflow.clip,
                              )
                            : const SizedBox(),
                        SizedBox(
                            height: image.isEmpty ? 0 : Get.height * 0.015),
                        image.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                height: (image.length == 2)
                                    ? height * 0.13
                                    : (image.length == 1)
                                        ? height * 0.25
                                        : height * 0.26,
                                width: width * 0.55,
                                child: MultiplePhoto(
                                  images: image,
                                  moreThan4: width * 0.5,
                                  isEqualorLessThan1: width * 1,
                                ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.1,
            child: Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
