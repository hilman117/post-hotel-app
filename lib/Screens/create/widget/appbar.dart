import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/l10n/app_localizations.dart';

class CreateTaskAppBar extends StatelessWidget {
  const CreateTaskAppBar(
      {super.key, required this.isTask, required this.sendTo});

  final bool isTask;
  final String sendTo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final app = AppLocalizations.of(context);
    return isTask
        ? Text(
            "${app!.sendThisTo} $sendTo",
            style: TextStyle(color: theme.focusColor, fontSize: 14.sp),
          )
        : Text("Lost And Found",
            style: TextStyle(color: theme.focusColor, fontSize: 14.sp));
  }
}
