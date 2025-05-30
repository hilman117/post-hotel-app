import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/ios_view/ios_image_picker.dart';
import 'package:provider/provider.dart';

class ListImagesComment extends StatelessWidget {
  const ListImagesComment({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<ChatRoomController>(
          builder: (context, value, child) => SizedBox(
              height: height * 0.1,
              width: width * 0.9,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: value.imagesList.length,
                      (BuildContext context, int index) {
                        if (value.imagesList[index] != null) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            width: width * 0.25,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  child: Image.file(
                                    File(value.imagesList[index]!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                value.isImageLoad == true
                                    ? Container(
                                        color: Colors.black45,
                                        height: height * 0.1,
                                        width: width * 0.2,
                                        child: Lottie.asset(
                                            "images/loadimage.json"))
                                    : const SizedBox(),
                                Positioned(
                                  left: width * 0.13,
                                  bottom: height * 0.05,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: const Icon(Icons.cancel_outlined),
                                    color: Colors.grey,
                                    onPressed: () =>
                                        Provider.of<ChatRoomController>(context,
                                                listen: false)
                                            .removeSingleImage(index),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: IconButton(
                          splashRadius: 20,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: () => iosImagePicker(context, false),
                          icon: const Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.grey,
                          ))),
                ],
              )),
        )
      ],
    );
  }
}
