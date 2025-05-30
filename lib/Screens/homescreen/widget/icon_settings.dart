import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../settings/settings.dart';

class IconSettings extends StatelessWidget {
  const IconSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<HomeController>(
            builder: (context, value, child) => CircleAvatar(
                radius: 3,
                backgroundColor: box!.get('dutyStatus') == true
                    ? Colors.lightGreenAccent
                    : Colors.grey)),
        SizedBox(
          width: Get.width * 0.01,
        ),
        Consumer<HomeController>(
            builder: (context, value, child) => Text(
                  box!.get('dutyStatus') == true ? "On Duty" : 'Off Duty',
                  style: TextStyle(
                      fontSize: 13,
                      color: box!.get('dutyStatus') == true
                          ? Colors.lightGreenAccent
                          : Colors.grey),
                )),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () =>
                Get.to(() => const Settings(), transition: Transition.rightToLeft),
            radius: 50,
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: Colors.transparent,
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Icon(
                  Icons.settings,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
