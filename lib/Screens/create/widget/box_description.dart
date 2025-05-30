import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/l10n/app_localizations.dart';
import '../../../service/theme.dart';

class BoxDescription extends StatelessWidget {
  final TextEditingController controller;
  const BoxDescription({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: fullWidth < maxWidth ? 8.sp : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.description,
              style: TextStyle(
                  color: theme.focusColor,
                  fontSize: fullWidth < maxWidth ? 15.sp : 15)),
          SizedBox(height: Get.height * 0.01),
          Container(
            height: landscape ? Get.height * 0.3 : Get.height * 0.13,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: theme.canvasColor),
                borderRadius:
                    BorderRadius.circular(fullWidth < maxWidth ? 10.r : 10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: TextFormField(
                style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                    color: theme.focusColor),
                cursorHeight: fullWidth < maxWidth ? 17.h : 17,
                cursorColor: mainColor.withOpacity(0.5),
                controller: controller,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 1,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: fullWidth < maxWidth ? 8.sp : 8),
                    hintText: AppLocalizations.of(context)!.typeHere,
                    hintStyle: TextStyle(
                        overflow: TextOverflow.clip,
                        color: theme.focusColor,
                        fontWeight: FontWeight.normal),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
