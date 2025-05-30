import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/models/lf_model.dart';
import '../../../controller/c_user.dart';
import '../../../service/theme.dart';
import '../../../common_widget/status.dart';
import '../../homescreen/widget/animated/animated_receiver.dart';
import '../lf_chatroom.dart';

final cUser = Get.put(CUser());
double height = Get.height;
double width = Get.width;

class LoasNfoundCard extends StatefulWidget {
  const LoasNfoundCard(
      {super.key, required this.animationColor, required this.lfModel});

  final Color? animationColor;
  final LfModel? lfModel;

  @override
  State<LoasNfoundCard> createState() => _LoasNfoundCardState();
}

class _LoasNfoundCardState extends State<LoasNfoundCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int runnningTime =
    //     DateTime.now().difference(widget.lfModel.).inMinutes;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.7,
                    offset: const Offset(0.05, 0.05))
              ],
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.to(
                      () => LfChatRoom(
                          taskId: widget.lfModel!.id!,
                          hotelid: cUser.data.hotelid!,
                          status: widget.lfModel!.status!,
                          image: widget.lfModel!.image!,
                          nameOfReporter: widget.lfModel!.founder!,
                          locationItemFounded: widget.lfModel!.location!,
                          nameOfItemFounded: widget.lfModel!.nameItem!,
                          receiver: widget.lfModel!.receiver!,
                          photoProfileSender:
                              widget.lfModel!.profileImageSender!,
                          positionReporter: widget.lfModel!.positionSender!,
                          time: widget.lfModel!.time!,
                          emailSender: widget.lfModel!.emailSender!),
                      transition: Transition.rightToLeft);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.not_listed_location,
                              size: Get.width * 0.05,
                              color: mainColor,
                            ),
                            SizedBox(
                              width: Get.width * 0.015,
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: width * 0.6,
                                      child: Text(
                                        widget.lfModel!.nameItem!,
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    const Spacer(),
                                    StatusWidget(
                                      status: widget.lfModel!.status!,
                                      isFading: false,
                                      height: height * 0.04,
                                      fontSize: 13,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.004),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              size: Get.width * 0.05,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(
                              width: Get.width * 0.015,
                            ),
                            Expanded(
                              child: Container(
                                // height: 17,
                                child: Row(
                                  children: [
                                    // SizedBox(
                                    //   width: width * 0.075,
                                    // ),
                                    SizedBox(
                                      width: width * 0.40,
                                      child: Text(
                                        widget.lfModel!.location!,
                                        style: const TextStyle(fontSize: 15),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    const Spacer(),
                                    AnimatedReceiver(
                                      receiver: widget.lfModel!.receiver!,
                                      status: widget.lfModel!.status!,
                                      assigned: const [],
                                      isFading: false,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.002,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.065,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                children: [
                                  Container(
                                    // height: 17,
                                    child: Row(
                                      children: [
                                        // SizedBox(
                                        //   width: width * 0.077,
                                        // ),
                                        SizedBox(
                                          width: width * 0.60,
                                          child: Text(
                                            widget.lfModel!.founder!,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xffBDBDBD)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        if (widget.lfModel!.description != '')
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.065,
                              ),
                              SizedBox(
                                width: width * 0.60,
                                child: Text(
                                  widget.lfModel!.description!,
                                  style: const TextStyle(
                                      fontSize: 13, color: Color(0xffBDBDBD)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                      ]),
                ),
              ),
            )));
  }
}
