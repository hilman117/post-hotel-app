import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

import '../../homescreen/home_controller.dart';
import '../setting_provider.dart';

void logoutDialog(context) {
  final theme = Theme.of(context);
  final user = Get.put(CUser());
  final eventHome = Provider.of<HomeController>(context, listen: false);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(
            "${AppLocalizations.of(context)!.logOutDialog}?",
            style: TextStyle(
                color: theme.focusColor,
                fontSize: fullWidth < maxWidth ? 14.sp : 14),
          ),
          actions: [
            CupertinoButton(
              child: Text(
                AppLocalizations.of(context)!.no,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: fullWidth < maxWidth ? 14.sp : 14),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Consumer<HomeController>(builder: (context, value, child) {
              return CupertinoButton(
                  child: Text(
                    AppLocalizations.of(context)!.yes,
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: fullWidth < maxWidth ? 14.sp : 14),
                  ),
                  onPressed: () async {
                    await Provider.of<SettingProvider>(context, listen: false)
                        .signOut(context);
                  });
            }),
          ],
        );
      });
}
