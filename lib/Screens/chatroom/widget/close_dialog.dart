import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/core.dart';
import 'package:provider/provider.dart';

import '../../../global_function.dart';
import '../chatroom_controller.dart';

void closeDialog(context, TaskModel taskModel, ScrollController scroll) {
  final app = AppLocalizations.of(context);
  TextEditingController closetext = TextEditingController();
  final theme = Theme.of(context);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Material(
            color: Colors.transparent,
            child: LimitedBox(
              // color: Colors.transparent,
              // width: double.infinity,
              // alignment: Alignment.center,
              // height: fullWidth < maxWidth ? 100.w : 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    app!.areYouSureWantToCloseThisRequest,
                    style: TextStyle(
                        fontSize: fullWidth < maxWidth ? 14.sp : 14,
                        color: theme.focusColor),
                  ),
                  SizedBox(
                    height: fullWidth < maxWidth ? 10.h : 10,
                  ),
                  Container(
                    height: fullWidth < maxWidth ? 35.h : 35,
                    width: fullWidth < maxWidth ? 300.w : 300,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: CupertinoTextField(
                      style: TextStyle(
                          fontSize: fullWidth < maxWidth ? 14.sp : 14,
                          color: theme.focusColor),
                      controller: closetext,
                      placeholder: app.typeHere,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CupertinoButton(
              child: Text(
                app.no,
                style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 14.w : 14,
                    color: Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(
                app.yes,
                style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 14.w : 14,
                    color: CupertinoColors.activeBlue),
              ),
              onPressed: () async {
                if (Provider.of<GlobalFunction>(context, listen: false)
                        .hasInternetConnection ==
                    true) {
                  await Provider.of<ChatRoomController>(context, listen: false)
                      .close(context, taskModel, scroll, closetext.text);
                } else {
                  Provider.of<GlobalFunction>(context, listen: false)
                      .noInternet(app.noInternetPleaseCheckYourConnection);
                }
              },
            ),
          ],
        );
      });
}
