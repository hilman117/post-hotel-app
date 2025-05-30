import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCreateAcount extends StatelessWidget {
  const FormCreateAcount(
      {super.key,
      required this.label,
      required this.textContronller,
      this.enterButtonAction,
      this.isPasswordForm,
      this.typingFunction});
  final String label;
  final TextEditingController textContronller;
  final TextInputAction? enterButtonAction;
  final bool? isPasswordForm;
  final Function(String)? typingFunction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return SizedBox(
      height: fullWidth < maxWidth ? 50.h : 50,
      child: TextFormField(
        onChanged: typingFunction,
        style: TextStyle(
            letterSpacing: -0.5,
            color: theme.focusColor,
            fontSize: fullWidth < maxWidth ? 16.sp : 16),
        obscureText: isPasswordForm ?? false,
        controller: textContronller,
        textInputAction: enterButtonAction ?? TextInputAction.done,
        decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(
                letterSpacing: -0.5,
                color: theme.focusColor.withOpacity(0.3),
                fontSize: fullWidth < maxWidth ? 16.sp : 16),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(fullWidth < maxWidth ? 13.r : 13),
                borderSide:
                    BorderSide(color: theme.focusColor.withOpacity(0.3))),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(fullWidth < maxWidth ? 8.r : 8),
                borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: fullWidth < maxWidth ? 1.w : 1))),
      ),
    );
  }
}
