import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditImage extends StatelessWidget {
  final File? image;
  const EditImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: Get.height * 0.85,
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                )),
          ),
          const CircleAvatar(
            radius: 25,
            child: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
