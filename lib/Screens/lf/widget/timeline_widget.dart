import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';

class Timeline extends StatelessWidget {
  final String founder;
  const Timeline({super.key, required this.founder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                side: const BorderSide(width: 0),
                splashRadius: 20,
                activeColor: mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                value: true,
                onChanged: (value) {},
              ),
              Text(
                "$founder has reported this",
                style: TextStyle(color: Colors.grey.shade500),
              )
            ],
          )
        ],
      ),
    );
  }
}
