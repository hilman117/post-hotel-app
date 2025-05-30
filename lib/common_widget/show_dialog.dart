import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ShowDialog {
  Future alerDialog(BuildContext context, String text) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            "Error!",
            style: TextStyle(fontSize: fullWidth < maxWidth ? 16.sp : 16),
          ),
          content: Text(
            text,
            style: TextStyle(fontSize: fullWidth < maxWidth ? 16.sp : 16),
          ),
          actions: [
            CupertinoButton(
                child: const Text("Retry"),
                onPressed: () => Navigator.of(context).pop())
          ],
        ),
      );
    }
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: theme.cardColor,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Retry",
                style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 16.sp : 16,
                    fontWeight: FontWeight.bold,
                    color: theme.focusColor),
              ))
        ],
        title: Text(
          text,
          style: TextStyle(
              fontSize: fullWidth < maxWidth ? 16.sp : 16,
              fontWeight: FontWeight.normal,
              color: theme.focusColor),
        ),
      ),
    );
  }

  Future errorDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Retry",
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ))
        ],
        title: Text(
          text,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ),
    );
  }

  Future succesDialog(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Ok!",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ))
          ],
          title: Column(
            children: [
              Lottie.asset("image/success.json", width: 100.w, height: 100.h),
              Text(
                text,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              )
            ],
          )),
    );
  }

  Future deleteSucces(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Center(
                child: LimitedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset("image/deleted.json",
                      width: 100.w, height: 100.h),
                ],
              ),
            )));
  }

  Future confirmDialog(
      BuildContext context, String questions, VoidCallback function) {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text(
            questions,
            style: TextStyle(fontSize: fullWidth < maxWidth ? 16.sp : 16),
          ),
          actions: [
            CupertinoButton(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop()),
            CupertinoButton(child: const Text("Yes"), onPressed: () => function)
          ],
        ),
      );
    }
    return showDialog(
        context: context,
        builder: (context) => LimitedBox(
              child: AlertDialog(
                  shadowColor: Colors.transparent,
                  backgroundColor: theme.cardColor,
                  actions: [
                    OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 16.sp, color: theme.focusColor),
                        )),
                    OutlinedButton(
                        onPressed: function,
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              fontSize: 16.sp, color: theme.primaryColor),
                        )),
                  ],
                  content: Text(
                    questions,
                    style: TextStyle(fontSize: 16.sp, color: theme.focusColor),
                  )),
            ));
  }
}
