import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:provider/provider.dart';

class StatusWidget extends StatefulWidget {
  final String status;
  final double height;
  final double fontSize;
  final bool isFading;
  const StatusWidget(
      {super.key,
      required this.status,
      required this.isFading,
      required this.height,
      required this.fontSize});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget>
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

  @override
  void dispose() {
    notTrue.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ChatRoomController>(
        builder: (context, value, child) => FadeTransition(
            opacity: widget.isFading || widget.status == 'ESC'
                ? _animation
                : notTrue,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(1.sp),
              // height: p1.maxHeight * widget.height,
              // width: widget.width,
              decoration: BoxDecoration(
                // border: Border.all(
                //   width: 1.w,
                //   color: (widget.status == 'New')
                //       ? Colors.red.shade600
                //       : (widget.status == 'Accepted')
                //           ? Colors.green.shade600
                //           : (widget.status == 'Reopen')
                //               ? Colors.green.shade600
                //               : (widget.status == 'ESC')
                //                   ? Colors.red.shade600
                //                   : (widget.status == 'Close' ||
                //                           widget.status == "Release" ||
                //                           widget.status == "Claimed")
                //                       ? Colors.grey.shade600
                //                       : (widget.status == 'Hold')
                //                           ? Colors.grey
                //                           : (widget.status == 'Assigned')
                //                               ? Colors.blue.shade900
                //                               : Colors.blue.shade200,
                // ),
                borderRadius: BorderRadius.circular(6.r),
                color: (widget.status == 'New')
                    ? Colors.red.shade600.withOpacity(0.1)
                    : (widget.status == 'Accepted')
                        ? Colors.green.shade600.withOpacity(0.1)
                        : (widget.status == 'Reopen')
                            ? Colors.green.shade600.withOpacity(0.1)
                            : (widget.status == 'ESC')
                                ? Colors.red.shade600.withOpacity(0.1)
                                : (widget.status == 'Close' ||
                                        widget.status == "Release" ||
                                        widget.status == "Claimed")
                                    ? Colors.grey.shade600.withOpacity(0.1)
                                    : (widget.status == 'Hold')
                                        ? Colors.grey
                                        : (widget.status == 'Assigned')
                                            ? Colors.blue.shade900
                                                .withOpacity(0.1)
                                            : Colors.blue.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: (widget.status == 'New')
                        ? Colors.red.shade600
                        : (widget.status == 'Accepted')
                            ? Colors.green.shade600
                            : (widget.status == 'Reopen')
                                ? Colors.green.shade600
                                : (widget.status == 'ESC')
                                    ? Colors.red.shade600
                                    : (widget.status == 'Close' ||
                                            widget.status == "Release" ||
                                            widget.status == "Claimed")
                                        ? Colors.grey.shade600
                                        : (widget.status == 'Hold')
                                            ? Colors.grey
                                            : (widget.status == 'Assigned')
                                                ? Colors.blue.shade900
                                                : Colors.blue.shade200,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    (widget.status == 'New')
                        ? AppLocalizations.of(context)!.newStatus
                        : (widget.status == 'Release')
                            ? "Release"
                            : (widget.status == 'Claimed')
                                ? "Claimed"
                                : (widget.status == 'Accepted')
                                    ? AppLocalizations.of(context)!.accepted
                                    : (widget.status == 'Assigned')
                                        ? AppLocalizations.of(context)!.assigned
                                        : (widget.status == 'Reopen')
                                            ? AppLocalizations.of(context)!
                                                .reopen
                                            : (widget.status == 'ESC')
                                                ? AppLocalizations.of(context)!
                                                    .escalation
                                                : (widget.status == "Hold")
                                                    ? "Hold"
                                                    : (widget.status ==
                                                            "Resume")
                                                        ? "Resume"
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .close,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize,
                      color: (widget.status == 'New')
                          ? Colors.red.shade600
                          : (widget.status == 'Accepted')
                              ? Colors.green.shade600
                              : (widget.status == 'Reopen')
                                  ? Colors.green.shade600
                                  : (widget.status == 'ESC')
                                      ? Colors.red.shade600
                                      : (widget.status == 'Close' ||
                                              widget.status == "Release" ||
                                              widget.status == "Claimed")
                                          ? Colors.grey.shade600
                                          : (widget.status == 'Hold')
                                              ? Colors.grey
                                              : (widget.status == 'Assigned')
                                                  ? Colors.blue.shade900
                                                  : Colors.blue.shade200,
                      letterSpacing: -0.5.sp,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            )));
  }
}
