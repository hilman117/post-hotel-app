import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/create/widget/bottom_sheet_image_picker.dart';
import 'package:post_app/l10n/app_localizations.dart';
import '../../../service/theme.dart';

class ExecuteButton {
  // Color themeColor = const Color(0xffF8CCA5);
  // Color cardColor = const Color(0xff475D5B);
  Widget sendButton(BuildContext context, double widht, VoidCallback callback) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return SizedBox(
      height: landscape ? Get.height * 0.1 : Get.height * 0.055,
      width: Get.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: callback,
          child: Text(
            AppLocalizations.of(context)!.send,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  Widget imageButton(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    bool isDark = ThemeMode.system == ThemeMode.dark;
    return SizedBox(
      width: Get.width * 0.40,
      height: landscape ? Get.height * 0.09 : Get.height * 0.048,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
          onPressed: () {
            imagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.photo,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: isDark ? Colors.black : Colors.grey),
              ),
              Image.asset(
                'images/camera.png',
                width: 20,
              )
            ],
          )),
    );
  }
}
