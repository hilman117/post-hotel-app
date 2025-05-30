import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/homescreen/widget/timer.dart';
import 'package:post_app/Screens/ios_view/ios_assign_page.dart';
import 'package:post_app/Screens/ios_view/ios_chatroom.dart';
import 'package:post_app/common_widget/schedule_animated.dart';
import 'package:post_app/common_widget/status.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:provider/provider.dart';

import '../../../controller/c_user.dart';
import '../../../models/tasks.dart';
import '../chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);
final cUser = Get.put(CUser());
final taskmodel = Get.put(TaskModel());
double height = Get.height;
double width = Get.width;
// final cAccepted = Get.put(CAccepted())

class IosCardRequest extends StatefulWidget {
  const IosCardRequest({
    super.key,
    required this.data,
    required this.animationColor,
    required this.listImage,
    required this.listRequest,
    required this.listdDepartement,
  });
  final List<TaskModel> listRequest;
  final List<Departement> listdDepartement;
  final TaskModel data;
  final Color? animationColor;
  final List listImage;

  @override
  State<IosCardRequest> createState() => _IosCardRequestState();
}

class _IosCardRequestState extends State<IosCardRequest> {
  DateTime dateScheduleTask = DateTime.now();
  String _scheduleTask = DateFormat("dd MMMM").format(DateTime.now());
  bool darkmode = ThemeMode.system == ThemeMode.dark;
  final user = Get.put(CUser());
  ScrollController scroll = ScrollController();

  // double dynamicWidht(
  //     double maxWidht, double fullWidht, double utilWidht, double realWidht) {
  //   if (fullWidht < maxWidht) {
  //     return utilWidht;
  //   }
  //   return realWidht;
  // }

  @override
  void initState() {
    super.initState();
    // Workmanager().cancelAll();
  }

  @override
  void didChangeDependencies() {
    // Workmanager().cancelAll();
    if (widget.data.setDate!.isNotEmpty || widget.data.setTime!.isNotEmpty) {
      if (widget.data.setDate!.isNotEmpty) {
        setState(() {
          _scheduleTask = DateFormat("dd MMMM")
              .format(DateTime.parse(widget.data.setDate!).toLocal());
          dateScheduleTask = DateTime.parse(widget.data.setDate!).toLocal();
        });
      } else {
        _scheduleTask =
            DateFormat("dd MMMM").format(widget.data.time!.toDate().toLocal());
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    String now = DateFormat("dd MMMM").format(DateTime.now());
    final event = Provider.of<ChatRoomController>(context, listen: false);
    final bilingual = AppLocalizations.of(context);
    int colorCode = int.parse(widget.data.comment![0]["colorUser"]);
    Color color = Color(colorCode);
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoContextMenu.builder(
            enableHapticFeedback: true,
            builder: (context, animation) {
              if (animation.value > CupertinoContextMenu.animationOpensAt) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8.sp),
                      height: 300.h,
                      child: IosChatRoom(
                        taskModel: widget.data,
                        isTask: true,
                        isWithKeyboard: false,
                      )),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
                child: Material(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 5.sp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    tileColor: widget.data.status == "New"
                        ? widget.animationColor
                        : theme.cardColor,
                    onTap: () {
                      Provider.of<PopUpMenuProvider>(context, listen: false)
                          .changeTitle(widget.data.title!);
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return IosChatRoom(
                            taskModel: widget.data,
                            isTask: true,
                            isWithKeyboard: true,
                          );
                        },
                      ));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 20.w,
                              child: Image.network(
                                widget.data.iconDepartement!,
                                height: 15.h,
                                width: 15.w,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.data.title!,
                                  style: TextStyle(
                                      fontSize:
                                          fullWidth < maxWidth ? 16.sp : 16,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.5,
                                      color: theme.focusColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (widget.data.sendTo == cUser.data.department ||
                                widget.data.sender == cUser.data.name)
                              Icon(
                                widget.data.sendTo == cUser.data.department
                                    ? CupertinoIcons.arrow_down_left
                                    : CupertinoIcons.arrow_up_right,
                                size: 15.sp,
                              ),
                            SizedBox(
                              width: 5.w,
                            ),
                            SizedBox(
                              width: fullWidth < maxWidth ? 80.h : 80,
                              child: StatusWidget(
                                  status: widget.data.status!,
                                  isFading: widget.data.isFading!,
                                  height: height,
                                  fontSize: fullWidth < maxWidth ? 14.sp : 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              alignment: Alignment.centerLeft,
                              child: Builder(
                                builder: (context) {
                                  if (widget.data.image!.isNotEmpty) {
                                    return Icon(
                                      Icons.attach_file,
                                      size: fullWidth < maxWidth ? 13.sp : 13,
                                      color: widget.data.status != "Close"
                                          ? Colors.black
                                          : Colors.grey,
                                    );
                                  } else {
                                    return SizedBox(
                                      height: 15.h,
                                      width: 15.w,
                                    );
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // width: fullWidth < maxWidth ? 250.w : 400,
                                child: Text(
                                  widget.data.location!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.5,
                                      fontSize:
                                          fullWidth < maxWidth ? 16.sp : 16,
                                      color: theme.focusColor),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            Builder(builder: (context) {
                              if (widget.data.status == "Assigned") {
                                return Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    // width: fullWidth < maxWidth ? 250.w : 400,
                                    child: Text(
                                      "${bilingual.to} ${widget.data.assigned!.last}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: -0.5,
                                          fontSize:
                                              fullWidth < maxWidth ? 13.sp : 13,
                                          color: theme.focusColor),
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                );
                              }
                              return Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  // width: fullWidth < maxWidth ? 250.w : 400,
                                  child: (widget.data.receiver!.isNotEmpty)
                                      ? Text(
                                          "${bilingual.by} ${widget.data.receiver!}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: -0.5,
                                              fontSize: fullWidth < maxWidth
                                                  ? 13.sp
                                                  : 13,
                                              color: theme.focusColor),
                                          textAlign: TextAlign.end,
                                          overflow: TextOverflow.clip,
                                        )
                                      : const SizedBox(),
                                ),
                              );
                            }),
                          ],
                        ),
                        if (widget.data.setTime!.isNotEmpty)
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 20.w,
                                child: Builder(
                                  builder: (context) {
                                    if (widget.data.setTime!.isNotEmpty) {
                                      return Icon(
                                        CupertinoIcons.calendar,
                                        size: fullWidth < maxWidth ? 13.sp : 13,
                                        color: widget.data.status != "Close"
                                            ? Colors.red
                                            : Colors.grey,
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                              ScheduleAnimated(
                                  data: widget.data,
                                  timeNow: now,
                                  schedule: _scheduleTask),
                            ],
                          ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // width: fullWidth < maxWidth ? 250.w : 400,
                                child: Text(
                                  widget.data.sender!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.5,
                                      fontSize:
                                          fullWidth < maxWidth ? 13.sp : 13,
                                      color: Colors.grey),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            Text(
                              remainingDateTime(
                                  context, widget.data.time!.toDate()),
                              style: TextStyle(
                                  fontSize: fullWidth < maxWidth ? 12.sp : 12,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            if (widget.data.description!.isNotEmpty)
                              Expanded(
                                child: Text(
                                  widget.data.description!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.5,
                                      fontSize:
                                          fullWidth < maxWidth ? 13.sp : 13,
                                      color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            actions: [
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                  event.accept(
                    context,
                    widget.data,
                    "${user.data.name} has accept this request",
                    "tasks",
                    "Accepted",
                    scroll,
                  );
                },
                trailingIcon: CupertinoIcons.check_mark,
                child: Text(bilingual!.accept),
              ),
              CupertinoContextMenuAction(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return IosAssignPage(task: widget.data, scrol: scroll);
                    },
                  ));
                  await event.getDeptartementAndNames();
                },
                trailingIcon: CupertinoIcons.arrowshape_turn_up_left,
                child: Text(bilingual.assign),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<PopUpMenuProvider>(context, listen: false)
                      .changeTitle(widget.data.title!);
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return IosChatRoom(
                        taskModel: widget.data,
                        isTask: true,
                        isWithKeyboard: true,
                      );
                    },
                  ));
                },
                trailingIcon: CupertinoIcons.forward,
                child: const Text("Open"),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  event.close(
                    context,
                    widget.data,
                    scroll,
                    "",
                  );
                },
                isDestructiveAction: true,
                trailingIcon: CupertinoIcons.clear,
                child: Text(bilingual.close),
              )
            ],
          ),
        ],
      ),
    );
  }
}
