import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:provider/provider.dart';

import 'image_room2.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final double moreThan4;
  final double isEqualorLessThan1;
  final List<dynamic> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  const PhotoGrid(
      {required this.imageUrls,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      super.key,
      required this.moreThan4,
      required this.isEqualorLessThan1});

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    return GridView(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: (widget.imageUrls.length <= 1)
            ? widget.isEqualorLessThan1
            : widget.moreThan4,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: Image.network(imageUrl, fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return Lottie.asset("images/loadimage.json", width: 100);
              } else {
                return child;
              }
            }),
            onTap: () => Get.to(
                () => ImageRoom2(
                      image: imageUrl,
                      tag:
                          "tag${widget.imageUrls.length + Random().nextInt(1000)}",
                      imageList: widget.imageUrls,
                      indx: index,
                    ),
                transition: Transition.rightToLeft),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => Get.to(
                () => ImageRoom2(
                      image: imageUrl,
                      tag:
                          "tag${widget.imageUrls.length + Random().nextInt(1000)}",
                      imageList: widget.imageUrls,
                      indx: index,
                    ),
                transition: Transition.rightToLeft),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Lottie.asset("images/loadimage.json", width: 100);
                  } else {
                    return child;
                  }
                }),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+$remaining',
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
            child: Image.network(
              imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return Lottie.asset("images/loadimage.json", width: 100);
                } else {
                  return child;
                }
              },
              fit: BoxFit.cover,
            ),
            onTap: () {
              Get.to(
                  () => ImageRoom2(
                        image: imageUrl,
                        tag:
                            "tag${widget.imageUrls.length + Random().nextInt(1000)}",
                        imageList: widget.imageUrls,
                        indx: index,
                      ),
                  transition: Transition.rightToLeft);
              Provider.of<ChatRoomController>(context, listen: false)
                  .currentIndex(index);
            });
      }
    });
  }
}
