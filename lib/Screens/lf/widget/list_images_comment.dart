import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/lf/lf_controller.dart';
import 'package:provider/provider.dart';

import '../../chatroom/widget/image_picker.dart';

class ListImagesComment extends StatelessWidget {
  const ListImagesComment({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<ReportLFController>(
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
                                    color: Colors.red,
                                    onPressed: () =>
                                        Provider.of<ReportLFController>(context,
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
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                        splashRadius: 20,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () => imagePickerBottomSheet(
                            context: context, height: height, widht: width),
                        icon: const Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.grey,
                        )),
                  )),
                ],
              )),
        )
      ],
    );
  }
}
