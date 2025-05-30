import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameItemBox extends StatelessWidget {
  final String itemName;
  final String founder;
  final String location;
  final String time;
  const NameItemBox(
      {super.key,
      required this.itemName,
      required this.founder,
      required this.location,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            founder,
            style: const TextStyle(color: Colors.grey),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            'Location: $location',
            style: const TextStyle(color: Colors.grey),
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            "Time: $time",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
