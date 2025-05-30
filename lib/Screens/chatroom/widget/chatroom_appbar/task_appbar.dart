import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'package:post_app/core.dart';
import 'package:provider/provider.dart';
import 'package:post_app/l10n/app_localizations.dart';
import '../../../../common_widget/status.dart';
import '../../../../service/theme.dart';
import '../../../create/create_request_controller.dart';
import '../../chatroom_controller.dart';

class TaskAppBar extends StatelessWidget {
  final TaskModel taskmodel;

  const TaskAppBar({
    super.key,
    required this.taskmodel,
  });

  @override
  Widget build(BuildContext context) {
    final applications = AppLocalizations.of(context);
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(
            horizontal: fullWidth < maxWidth ? 5.sp : 5,
            vertical: fullWidth < maxWidth ? 10.h : 10),
        padding: EdgeInsets.all(fullWidth < maxWidth ? 5.sp : 5),
        width: double.infinity,
        decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius:
                BorderRadius.circular(fullWidth < maxWidth ? 10.r : 10),
            boxShadow: Theme.of(context).brightness == Brightness.dark
                ? []
                : [
                    const BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        offset: Offset(1, 1))
                  ]),
        child: Consumer<ChatRoomController>(
          builder: (context, value, child) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onLongPress: () =>
                        Fluttertoast.showToast(msg: "Go Previous Page"),
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded,
                            color: theme.primaryColor,
                            size: fullWidth < maxWidth ? 30.sp : 30),
                        SizedBox(
                            height: fullWidth < maxWidth ? 30.h : 30,
                            width: fullWidth < maxWidth ? 30.w : 30,
                            child: Image.asset(taskmodel.typeReport == "tasks"
                                ? '${taskmodel.iconDepartement}'
                                : "images/lf.png")),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: fullWidth < maxWidth ? 10.w : 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskmodel.title!,
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 14.sp : 14,
                            fontWeight: FontWeight.normal,
                            color: theme.focusColor),
                      ),
                      SizedBox(
                        height: fullWidth < maxWidth ? 5.h : 5,
                      ),
                      Consumer<PopUpMenuProvider>(
                        builder: (context, value, child) => Text(
                          value.location,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 14.sp : 14,
                              fontWeight: FontWeight.normal,
                              color: theme.focusColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StatusWidget(
                    status: value.status,
                    isFading: false,
                    height: fullWidth < maxWidth ? 1.h : 1,
                    fontSize: fullWidth < maxWidth ? 11.sp : 11,
                  ),
                  (value.status != 'Assigned')
                      ? Container(
                          margin: EdgeInsets.only(
                              top: fullWidth < maxWidth ? 5.h : 5),
                          width: fullWidth < maxWidth ? 150.w : 200,
                          child: value.receiver != ''
                              ? Text(
                                  value.status != 'Assigned'
                                      ? "${applications!.by} ${value.receiver}"
                                      : "${applications!.to} ${value.assignTo}",
                                  style: TextStyle(
                                      color: secondary,
                                      fontSize:
                                          fullWidth < maxWidth ? 11.sp : 11),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                )
                              : SizedBox(
                                  height: fullWidth < maxWidth ? 5.h : 5),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                              top: fullWidth < maxWidth ? 5.sp : 5),
                          width: fullWidth < maxWidth ? 150.w : 200,
                          child: value.status == 'Assigned'
                              ? Text(
                                  "${applications!.to} ${value.assignTo}",
                                  style: TextStyle(
                                      color: secondary,
                                      fontSize:
                                          fullWidth < maxWidth ? 11.sp : 11),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.end,
                                )
                              : const SizedBox(),
                        ),
                  Consumer<CreateRequestController>(
                      builder: (context, val, child) {
                    if (val.selectedTime.isNotEmpty && val.datePicked.isEmpty) {
                      return SizedBox(
                        width: fullWidth < maxWidth ? 150.w : 50,
                        child: Text(
                          "Due ${val.selectedTime}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: fullWidth < maxWidth ? 12.sp : 12),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                        ),
                      );
                    }

                    if (val.datePicked.isNotEmpty) {
                      DateTime scheduleTask = DateTime.parse(val.datePicked);
                      String taskSchedule =
                          DateFormat("EEE, dd MMMM").format(scheduleTask);
                      String now =
                          DateFormat("EEE, dd MMMM").format(DateTime.now());
                      return SizedBox(
                        width: fullWidth < maxWidth ? 150.w : 200,
                        child: Text(
                          taskSchedule == now
                              ? "Due ${val.selectedTime}"
                              : "Due $taskSchedule ${val.selectedTime}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: fullWidth < maxWidth ? 12.sp : 12),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                        ),
                      );
                    }
                    return const SizedBox();
                  })
                ],
              )
            ],
          ),
        ));
  }
}
