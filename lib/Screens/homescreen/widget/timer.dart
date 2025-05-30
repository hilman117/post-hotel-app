import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

String remainingDateTime(BuildContext context, DateTime dateTime) {
  final app = AppLocalizations.of(context);
  int differentDays = DateTime.now().difference(dateTime).inDays;
  int differentHour = DateTime.now().difference(dateTime).inHours;
  int differentMinute = DateTime.now().difference(dateTime).inMinutes;
  int differentSecond = DateTime.now().difference(dateTime).inSeconds;

  if (differentDays >= 30) {
    String monthAgo = DateFormat("dd MMM yyyy").format(dateTime);
    return monthAgo;
  }
  if (differentDays >= 21 && differentDays < 30) {
    return '3 ${app!.weeks}';
  }
  if (differentDays >= 14 && differentDays < 21) {
    return '2 ${app!.weeks}';
  }
  if (differentDays >= 7 && differentDays < 14) {
    return app!.week;
  }
  if (differentDays == 1) {
    return '$differentDays ${app!.oneDayAgo}';
  }
  if (differentDays > 1) {
    return '$differentDays ${app!.daysAgo}';
  }
  if (differentHour == 1) {
    return '$differentHour ${app!.oneHourAgo}';
  }
  if (differentHour > 1) {
    return '$differentHour ${app!.hours}';
  }
  if (differentMinute == 1) {
    return '$differentMinute ${app!.minuteAgo}';
  }
  if (differentMinute > 1) {
    return '$differentMinute ${app!.minutesAgo}';
  }
  if (differentSecond < 60) {
    return app!.justNow;
  }
  return '$differentDays ${app!.daysAgo}';
}
