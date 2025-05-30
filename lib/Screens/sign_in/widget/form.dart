import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../service/theme.dart';

class InputForm extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final bool isObsecure;
  final VoidCallback callback;
  final TextInputType textInputType;
  final TextInputAction action;
  const InputForm(
      {super.key,
      required this.icon,
      required this.controller,
      required this.hintText,
      required this.isObsecure,
      required this.callback,
      required this.textInputType,
      required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(color: theme.shadowColor),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: InkWell(
                  radius: 15,
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onTap: callback,
                  child: Icon(icon, color: theme.primaryColor, size: 22))),
          Expanded(
            child: SizedBox(
                height: Get.height * 0.045,
                child: TextFormField(
                  textInputAction: action,
                  keyboardType: textInputType,
                  obscureText: isObsecure,
                  controller: controller,
                  style: TextStyle(fontSize: 16.sp, color: theme.focusColor),
                  cursorColor: mainColor,
                  cursorHeight: 16.sp,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle:
                          TextStyle(fontSize: 16.sp, color: theme.hintColor),
                      contentPadding: const EdgeInsets.only(bottom: 15),
                      border: InputBorder.none),
                )),
          )
        ],
      ),
    );
  }
}
