import 'package:flutter/material.dart';
import 'package:post_app/Screens/chatroom/widget/photo_grid.dart';

class MultiplePhoto extends StatelessWidget {
  final List<dynamic> images;
  final double moreThan4;
  final double isEqualorLessThan1;
  const MultiplePhoto(
      {super.key,
      required this.images,
      required this.moreThan4,
      required this.isEqualorLessThan1});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoGrid(
        imageUrls: images,
        onImageClicked: (i) => print('Image $i was clicked!'),
        onExpandClicked: () => print('Expand Image was clicked'),
        maxImages: 4,
        key: null,
        moreThan4: moreThan4,
        isEqualorLessThan1: isEqualorLessThan1,
      ),
    );
  }
}
