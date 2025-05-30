import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/widget/typing.dart';
import 'package:provider/provider.dart';

import '../../../service/theme.dart';
import '../home_controller.dart';
import 'search_icon.dart';

Widget searchButtonAndAdd(BuildContext context) {
  return Tooltip(
    textStyle: const TextStyle(color: Colors.black45),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.white)),
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    message: "Search",
    child: AnimatedContainer(
        height: Get.height * 0.070,
        curve: Curves.easeInOutSine,
        alignment: context.read<HomeController>().isCollapse
            ? Alignment.centerLeft
            : Alignment.center,
        duration: const Duration(milliseconds: 300),
        width: context.read<HomeController>().isCollapse
            ? Get.width * 0.75
            : Get.width * 0.15,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 0.5, color: mainColor)),
        child: context.read<HomeController>().isCollapse
            ? typing(context)
            : searchIcon(context)),
  );
}
