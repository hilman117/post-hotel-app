import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';

class ListImages extends StatelessWidget {
  final double getHeight;
  final double getWidht;
  const ListImages(
      {super.key, required this.getHeight, required this.getWidht});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<CreateRequestController>(
          builder: (context, value, child) => SizedBox(
              height: getHeight * 0.1,
              width: getWidht * 0.9,
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
                            width: getWidht * 0.25,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: getHeight * 0.1,
                                  width: getWidht * 0.2,
                                  child: Image.file(
                                    File(value.imagesList[index]!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: -18.sp,
                                  right: -18.sp,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      size: 15.sp,
                                    ),
                                    color: Colors.red,
                                    onPressed: () =>
                                        Provider.of<CreateRequestController>(
                                                context,
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
                ],
              )),
        )
      ],
    );
  }
}
