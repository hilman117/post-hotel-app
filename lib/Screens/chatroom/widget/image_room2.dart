// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../homescreen/widget/card_request.dart';

class ImageRoom2 extends StatefulWidget {
  final List<dynamic> imageList;
  final String image;
  final int indx;
  final String tag;
  const ImageRoom2(
      {super.key,
      required this.image,
      required this.tag,
      required this.imageList,
      required this.indx});

  @override
  State<ImageRoom2> createState() => _ImageRoom2State();
}

class _ImageRoom2State extends State<ImageRoom2> {
  final CarouselSliderController controller = CarouselSliderController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: CupertinoButton(
              onPressed: () => Get.back(),
              child: const Icon(CupertinoIcons.back)),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: width,
            // height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                    carouselController: controller,
                    items: List.generate(widget.imageList.length, (index) {
                      return Container(
                        alignment: Alignment.center,
                        height: height,
                        width: width,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Hero(
                            tag: widget.imageList[index],
                            child: Image.network(
                              widget.imageList[index],
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return Lottie.asset("images/loadimage.json",
                                      width: 100);
                                } else {
                                  return child;
                                }
                              },
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                        viewportFraction: 1,
                        aspectRatio: 640 / 1000,
                        initialPage: widget.indx,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                          provider.currentIndex(index);

                          // ignore: avoid_print
                          print(provider.current);
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: width * 0.18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              widget.imageList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => controller.animateToPage(entry.key),
                              child: Container(
                                width: width * 0.02,
                                height: height * 0.02,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: current == entry.key
                                        ? mainColor
                                        : Colors.grey.shade300),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () => Provider.of<ChatRoomController>(context,
                                listen: false)
                            .saveNetworkImage(
                                widget.imageList[provider.current]),
                        child: Icon(
                          Icons.download,
                          size: 30,
                          color: mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
