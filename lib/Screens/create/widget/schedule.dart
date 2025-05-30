import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SchedulePicker extends StatelessWidget {
  const SchedulePicker({super.key, required this.isTask});

  final bool isTask;

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context);
    double width = Get.width;
    double height = Get.height;
    final theme = Theme.of(context);
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Consumer<CreateRequestController>(
        builder: (context, value, child) => SizedBox(
              width: width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: fullWidth < maxWidth ? 8.sp : 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTask != true
                          ? '- - - - '
                          : AppLocalizations.of(context)!.setSchedule,
                      style: TextStyle(
                          fontSize: fullWidth < maxWidth ? 15.sp : 15,
                          color: value.isLfReport
                              ? Colors.grey
                              : theme.focusColor),
                    ),
                    value.datePicked != '' || value.selectedTime != ''
                        ? InkWell(
                            onTap: () => Provider.of<CreateRequestController>(
                                    context,
                                    listen: false)
                                .clearSchedule(),
                            child: Text(
                              "clear schedule",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: fullWidth < maxWidth ? 15.sp : 15),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: height * 0.01),
                    InkWell(
                      onTap: isTask != true
                          ? null
                          : () => Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .dateTimPicker(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: fullWidth < maxWidth ? 12.sp : 12),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: theme.canvasColor),
                            borderRadius: BorderRadius.circular(
                                fullWidth < maxWidth ? 12.sp : 12)),
                        width: Get.width,
                        height:
                            landscape ? Get.height * 0.1 : Get.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value.datePicked == ''
                                ? Text(
                                    isTask != true
                                        ? '- - - -'
                                        : AppLocalizations.of(context)!.date,
                                    style: TextStyle(
                                        color: theme.focusColor,
                                        fontSize:
                                            fullWidth < maxWidth ? 15.sp : 15),
                                  )
                                : Text(
                                    DateFormat('EE, MMM d').format(
                                        DateTime.parse(value.datePicked)),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            fullWidth < maxWidth ? 15.sp : 15)),
                            isTask != true
                                ? const SizedBox()
                                : Image.asset(
                                    'images/date.png',
                                    width: fullWidth < maxWidth ? 20.sp : 20,
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    GestureDetector(
                      onTap: isTask
                          ? () => Provider.of<CreateRequestController>(context,
                                  listen: false)
                              .timePIcker(context, app!)
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: fullWidth < maxWidth ? 12.sp : 12),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: theme.canvasColor),
                            borderRadius: BorderRadius.circular(12)),
                        width: Get.width,
                        height:
                            landscape ? Get.height * 0.1 : Get.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value.selectedTime == ''
                                ? Text(
                                    isTask != true ? '- - - - ' : 'Pick Time',
                                    style: TextStyle(
                                        color: isTask != true
                                            ? Colors.grey
                                            : theme.focusColor,
                                        fontSize:
                                            fullWidth < maxWidth ? 15.sp : 15),
                                  )
                                : Text(
                                    value.selectedTime,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            fullWidth < maxWidth ? 15.sp : 15),
                                  ),
                            isTask != true
                                ? const SizedBox()
                                : Image.asset(
                                    'images/time.png',
                                    width: fullWidth < maxWidth ? 20.w : 20,
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
