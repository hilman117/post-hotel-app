import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../service/theme.dart';

Widget typing(BuildContext context) {
  return Row(
    children: [
      CloseButton(
        color: Colors.grey,
        onPressed: () {
          context.read<HomeController>().changeValue();
        },
      ),
      Consumer<HomeController>(
        builder: (context, value, child) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: value.isCollapse ? Get.width * 0.015 : Get.width * 0.4,
          child: TextFormField(
            controller: Provider.of<HomeController>(context).text,
            onChanged: (value) =>
                Provider.of<HomeController>(context, listen: false)
                    .getInputTextSearch(value),
            cursorColor: mainColor,
            autofocus: true,
            style: const TextStyle(fontSize: 15),
            cursorHeight: 15,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.typeHere,
              border: InputBorder.none,
            ),
          ),
        ),
      )
    ],
  );
}
