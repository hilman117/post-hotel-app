import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/common_widget/status.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../homescreen/widget/card_request.dart';

class LfAppBar extends StatelessWidget {
  final String status;
  final List<String> image;
  final String nameOfReporter;
  final String receiver;
  final String nameOfItemFounded;
  final String locationItemFounded;
  final String photoProfileSender;
  final String positionReporter;
  final DateTime time;
  const LfAppBar({
    super.key,
    required this.status,
    required this.image,
    required this.nameOfReporter,
    required this.receiver,
    required this.nameOfItemFounded,
    required this.locationItemFounded,
    required this.photoProfileSender,
    required this.positionReporter,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final applications = AppLocalizations.of(context);
    return Container(
        margin: EdgeInsets.only(top: Get.height * 0.04),
        height: Get.height * 0.2,
        child: Consumer<ChatRoomController>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.054,
                // color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          height: Get.height * 0.045,
                          width: Get.width * 0.1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              photoProfileSender,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return Lottie.asset("images/loadimage.json");
                                }
                                return child;
                              },
                              fit: BoxFit.fill,
                            ),
                          )),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lost and found',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Text(
                            nameOfReporter,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          height: Get.height * 0.03,
                          child: StatusWidget(
                            status: status,
                            isFading: false,
                            height: height * 0.05,
                            fontSize: 12,
                          )),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                color: mainColor.withOpacity(0.2),
                width: Get.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.45,
                            child: Text(
                              'Item : $nameOfItemFounded',
                              style: TextStyle(color: secondary, fontSize: 14),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Text(
                              '${applications!.location}: $locationItemFounded',
                              style: TextStyle(color: secondary, fontSize: 14),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Text(
                              'Created : ${DateFormat('EEEE, MMM d, hh:mm').format(time)}',
                              style: TextStyle(color: secondary, fontSize: 14),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Consumer<CreateRequestController>(
                          builder: (context, val, child) => Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 0.0),
                                  SizedBox(
                                    width: Get.width * 0.40,
                                    child: receiver != ''
                                        ? Text(
                                            "${applications.by} $receiver",
                                            style: TextStyle(
                                                color: secondary, fontSize: 14),
                                            overflow: TextOverflow.clip,
                                            textAlign: TextAlign.end,
                                          )
                                        : const SizedBox(),
                                  ),
                                ],
                              ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
