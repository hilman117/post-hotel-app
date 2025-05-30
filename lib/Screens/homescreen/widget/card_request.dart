import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/widget/image_room2.dart';
import 'package:post_app/Screens/homescreen/widget/timer.dart';
import 'package:post_app/common_widget/status.dart';
import 'package:provider/provider.dart';
import '../../../controller/c_user.dart';
import '../../../models/tasks.dart';
import '../../chatroom/chatroom_task.dart';
import '../../chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'animated/animated_receiver.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);
final cUser = Get.put(CUser());
final taskmodel = Get.put(TaskModel());
double height = Get.height;
double width = Get.width;
// final cAccepted = Get.put(CAccepted())

class CardRequest extends StatefulWidget {
  const CardRequest({
    super.key,
    required this.data,
    required this.animationColor,
    required this.listImage,
    required this.listRequest,
  });
  final List<TaskModel> listRequest;
  final TaskModel data;
  final Color? animationColor;
  final List listImage;

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
  DateTime? dateScheduleTask;
  String? _scheduleTask;
  bool darkmode = ThemeMode.system == ThemeMode.dark;

  double dynamicWidht(
      double maxWidht, double fullWidht, double utilWidht, double realWidht) {
    if (fullWidht < maxWidht) {
      return utilWidht;
    }
    return realWidht;
  }

  @override
  void initState() {
    if (widget.data.setDate!.isNotEmpty) {
      setState(() {
        _scheduleTask =
            DateFormat("dd MMMM").format(DateTime.parse(widget.data.setDate!));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    int runnningTime =
        DateTime.now().difference(widget.data.time!.toDate()).inMinutes;
    String now = DateFormat("dd MMMM").format(DateTime.now());
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: fullWidth < maxWidth ? 5.sp : 5,
            vertical: fullWidth < maxWidth ? 5.sp : 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(fullWidth < maxWidth ? 16.r : 16),
            boxShadow: Theme.of(context).brightness == Brightness.dark
                ? []
                : [
                    BoxShadow(
                        // blurRadius: ,
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1.05,
                        offset: const Offset(0, 0.1))
                  ],
            color: widget.data.status == "New"
                ? widget.animationColor
                : theme.cardColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              radius: 0,
              borderRadius:
                  BorderRadius.circular(fullWidth < maxWidth ? 16.r : 16),
              splashFactory: InkSplash.splashFactory,
              onTap: () {
                Provider.of<PopUpMenuProvider>(context, listen: false)
                    .changeTitle(widget.data.title!);
                Get.to(
                    () => ChatRoomTask(
                          taskModel: widget.data,
                        ),
                    transition: Transition.rightToLeft);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: fullWidth < maxWidth ? 5.sp : 5,
                    horizontal: fullWidth < maxWidth ? 5.sp : 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    widget.data.iconDepartement!,
                                    fit: BoxFit.cover,
                                    width: fullWidth < maxWidth ? 25.w : 30,
                                  ),
                                  SizedBox(
                                    width: fullWidth < maxWidth ? 16.w : 16,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: fullWidth < maxWidth ? 150.w : 400,
                                    child: Text(
                                      widget.data.title!,
                                      style: TextStyle(
                                          fontSize:
                                              fullWidth < maxWidth ? 16.sp : 16,
                                          fontWeight: FontWeight.normal,
                                          color: theme.focusColor),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                              StatusWidget(
                                status: runnningTime >= 5 &&
                                        widget.data.status == "New"
                                    ? "ESC"
                                    : widget.data.status!,
                                isFading: widget.data.isFading!,
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 1
                                    : 1,
                                fontSize: fullWidth < maxWidth ? 13.sp : 13,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: fullWidth < maxWidth ? 4.h : 4),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  widget.listImage.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            String image =
                                                widget.listImage.first;
                                            Get.to(() => ImageRoom2(
                                                  image: image,
                                                  imageList: widget.listImage,
                                                  indx: 0,
                                                  tag: image,
                                                ));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: fullWidth < maxWidth
                                                    ? 10.sp
                                                    : 10,
                                                top: fullWidth < maxWidth
                                                    ? 5.sp
                                                    : 2),
                                            child: Icon(Icons.attach_file,
                                                color: const Color(0xff007dff),
                                                size: fullWidth < maxWidth
                                                    ? 16.sp
                                                    : 16),
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    width: widget.listImage.isEmpty
                                        ? dynamicWidht(
                                            maxWidth, fullWidth, 43.w, 45)
                                        : dynamicWidht(
                                            maxWidth, fullWidth, 19.w, 19),
                                  ),
                                  SizedBox(
                                    width: fullWidth < maxWidth ? 100.w : 300,
                                    child: Text(
                                      widget.data.location!,
                                      style: TextStyle(
                                          fontSize:
                                              fullWidth < maxWidth ? 14.sp : 14,
                                          color: theme.focusColor),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                              runnningTime >= 5 && widget.data.status == "New"
                                  ? Container(
                                      alignment: Alignment.centerRight,
                                      width: fullWidth < maxWidth ? 40.w : 40,
                                      child: Container(),
                                    )
                                  : AnimatedReceiver(
                                      receiver: widget.data.receiver!,
                                      status: widget.data.status!,
                                      assigned: widget.data.assigned!,
                                      isFading: widget.data.isFading!,
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.data.setDate! != '' ||
                              widget.data.setTime! != ''
                          ? 2.h
                          : height * 0.001,
                    ),
                    if (widget.data.setDate! != '' ||
                        widget.data.setTime! != '')
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                if (widget.data.setDate! != '' ||
                                    widget.data.setTime! != '')
                                  SizedBox(
                                      width: fullWidth < maxWidth ? 10.w : 10),
                                Icon(Icons.alarm,
                                    color: widget.data.status == 'Close'
                                        ? Colors.grey
                                        : Colors.red,
                                    size: fullWidth < maxWidth ? 15.sp : 15),
                                SizedBox(
                                    width: fullWidth < maxWidth ? 20.w : 20),
                                SizedBox(
                                  width: fullWidth < maxWidth ? 150.w : 200,
                                  child: Text(
                                    (widget.data.setDate!.isEmpty &&
                                            widget.data.setTime!.isNotEmpty)
                                        ? "Due ${widget.data.setTime}"
                                        : (now == _scheduleTask)
                                            ? "Today - at ${widget.data.setTime} "
                                            : "Due $_scheduleTask - ${widget.data.setTime}",
                                    // data.setDate!,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: widget.data.status == 'Close'
                                            ? Colors.grey
                                            : Colors.red,
                                        fontSize:
                                            fullWidth < maxWidth ? 13.sp : 13),
                                  ),
                                ),
                                const Spacer(),
                                if (widget.data.setDate! != '' ||
                                    widget.data.setTime! != '')
                                  SizedBox(
                                    width: fullWidth < maxWidth ? 130.w : 100,
                                    child: Text(
                                      remainingDateTime(
                                          context, widget.data.time!.toDate()),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize:
                                              fullWidth < maxWidth ? 12.sp : 12,
                                          color: Colors.blue),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: fullWidth < maxWidth ? 43.w : 45,
                                    ),
                                    SizedBox(
                                      width: fullWidth < maxWidth ? 150.w : 200,
                                      child: Text(
                                        widget.data.sender!,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: fullWidth < maxWidth
                                                ? 13.sp
                                                : 13,
                                            color: const Color(0xffBDBDBD)),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: fullWidth < maxWidth ? 130.w : 200,
                                  child: widget.data.setDate! == '' &&
                                          widget.data.setTime! == ''
                                      ? Text(
                                          remainingDateTime(context,
                                              widget.data.time!.toDate()),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: fullWidth < maxWidth
                                                  ? 12.sp
                                                  : 12,
                                              color: Colors.blue),
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: fullWidth < maxWidth ? 5.h : 5,
                    ),
                    if (widget.data.description! != '')
                      Row(
                        children: [
                          SizedBox(
                              height: fullWidth < maxWidth ? 2.h : 2,
                              width: fullWidth < maxWidth ? 43.w : 45),
                          SizedBox(
                            width: fullWidth < maxWidth ? 200.w : 300,
                            child: Text(
                              widget.data.description!,
                              style: TextStyle(
                                  fontSize: fullWidth < maxWidth ? 13.sp : 13,
                                  color: const Color(0xffBDBDBD)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class IosCardRequest extends StatelessWidget {
  const IosCardRequest({
    super.key,
    required this.widget,
    required this.theme,
    required this.fullWidth,
    required this.maxWidth,
    required this.runnningTime,
    required this.timeNow,
    required this.scheduleTime,
  });

  final CardRequest widget;
  final ThemeData theme;
  final double fullWidth;
  final double maxWidth;
  final int runnningTime;
  final String timeNow;
  final String scheduleTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            Provider.of<PopUpMenuProvider>(context, listen: false)
                .changeTitle(widget.data.title!);
            Get.to(
                () => ChatRoomTask(
                      taskModel: widget.data,
                    ),
                transition: Transition.rightToLeft);
          },
          selectedTileColor: widget.data.status == "New"
              ? widget.animationColor
              : theme.cardColor,
          minVerticalPadding: 0,
          isThreeLine: false,
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Hero(
              tag: widget.data.id!,
              child: Image.asset(
                widget.data.iconDepartement!,
                fit: BoxFit.cover,
                width: fullWidth < maxWidth ? 25.w : 30,
              ),
            ),
          ),
          title: Container(
            alignment: Alignment.centerLeft,
            width: fullWidth < maxWidth ? 150.w : 400,
            child: Text(
              widget.data.title!,
              style: TextStyle(
                  fontSize: fullWidth < maxWidth ? 16.sp : 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: theme.focusColor),
              overflow: TextOverflow.clip,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: fullWidth < maxWidth ? 100.w : 300,
                child: Text(
                  widget.data.location!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                      fontSize: fullWidth < maxWidth ? 14.sp : 14,
                      color: theme.focusColor),
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: fullWidth < maxWidth ? 150.w : 200,
                child: Text(
                  widget.data.sender!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: fullWidth < maxWidth ? 13.sp : 13,
                      color: const Color(0xffBDBDBD)),
                ),
              ),
              if (scheduleTime.isNotEmpty)
                Text(
                  (widget.data.setDate!.isEmpty &&
                          widget.data.setTime!.isNotEmpty)
                      ? "Due ${widget.data.setTime}"
                      : (timeNow == scheduleTime)
                          ? "Today - at ${widget.data.setTime} "
                          : "Due $scheduleTime - ${widget.data.setTime}",
                  // data.setDate!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: widget.data.status == 'Close'
                          ? Colors.grey
                          : Colors.red,
                      fontSize: fullWidth < maxWidth ? 13.sp : 13),
                ),
              if (widget.data.description!.isNotEmpty)
                SizedBox(
                  width: fullWidth < maxWidth ? 200.w : 300,
                  child: Text(
                    widget.data.description!,
                    style: TextStyle(
                        letterSpacing: -0.5,
                        fontSize: fullWidth < maxWidth ? 13.sp : 13,
                        color: const Color(0xffBDBDBD)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: fullWidth < maxWidth ? 80.sp : 80,
                child: StatusWidget(
                  status: runnningTime >= 5 && widget.data.status == "New"
                      ? "ESC"
                      : widget.data.status!,
                  isFading: widget.data.isFading!,
                  height: 1,
                  fontSize: fullWidth < maxWidth ? 13.sp : 13,
                ),
              ),
              runnningTime >= 5 && widget.data.status == "New"
                  ? Container(
                      alignment: Alignment.centerRight,
                      width: fullWidth < maxWidth ? 40.w : 40,
                      child: Container(),
                    )
                  : AnimatedReceiver(
                      receiver: widget.data.receiver!,
                      status: widget.data.status!,
                      assigned: widget.data.assigned!,
                      isFading: widget.data.isFading!,
                    ),
              SizedBox(
                // height: 20,
                // width: fullWidth < maxWidth ? 130.w : 200,
                child: Text(
                  remainingDateTime(context, widget.data.time!.toDate()),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: fullWidth < maxWidth ? 10.sp : 10,
                      color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
