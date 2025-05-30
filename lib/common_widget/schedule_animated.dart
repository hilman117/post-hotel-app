import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/core.dart';
import 'package:provider/provider.dart';

class ScheduleAnimated extends StatefulWidget {
  final TaskModel data;
  final String timeNow;
  final String schedule;
  const ScheduleAnimated({
    super.key,
    required this.data,
    required this.timeNow,
    required this.schedule,
  });

  @override
  State<ScheduleAnimated> createState() => _ScheduleAnimatedState();
}

class _ScheduleAnimatedState extends State<ScheduleAnimated>
    with TickerProviderStateMixin {
  late final AnimationController notTrue = AnimationController(
    value: 1,
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  bool isInThePast = false;
  DateTime scheduleDate = DateTime.now();
  DateTime scheduleTime = DateTime.now();
  late Duration duration;

  @override
  void initState() {
    if (widget.data.setDate!.isNotEmpty || widget.data.setTime!.isNotEmpty) {
      scheduleDate = widget.data.setDate!.isEmpty
          ? DateTime.now()
          : DateTime.parse(widget.data.setDate!).toLocal();
      DateTime parsedTime = DateTime.parse(widget.data.setTime!).toLocal();
      scheduleTime = DateTime(scheduleDate.year, scheduleDate.month,
          scheduleDate.day, parsedTime.hour, parsedTime.minute);
      duration = scheduleTime.difference(DateTime.now());
    }
    super.initState();
  }

  @override
  void dispose() {
    notTrue.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    // final theme = Theme.of(context);
    return Consumer<ChatRoomController>(
        builder: (context, value, child) => FadeTransition(
              opacity: duration < Duration.zero && widget.data.status != 'Close'
                  ? _animation
                  : notTrue,
              child: Builder(builder: (context) {
                if (widget.data.setTime!.isNotEmpty &&
                    widget.timeNow == widget.schedule) {
                  return Text(
                    "Today - at ${DateFormat("HH:mm").format(scheduleTime)}",
                    // data.setDate!,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: widget.data.status == 'Close'
                            ? Colors.grey
                            : Colors.red,
                        fontSize: fullWidth < maxWidth ? 13.sp : 13),
                  );
                }
                return Text(
                  "${widget.schedule} - ${DateFormat("HH:mm").format(scheduleTime)}",
                  // data.setDate!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: widget.data.status == 'Close'
                          ? Colors.grey
                          : Colors.red,
                      fontSize: fullWidth < maxWidth ? 13.sp : 13),
                );
              }),
            ));
  }
}
