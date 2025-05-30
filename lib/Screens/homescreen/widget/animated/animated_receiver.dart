import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedReceiver extends StatefulWidget {
  const AnimatedReceiver(
      {super.key,
      required this.receiver,
      required this.status,
      required this.assigned,
      required this.isFading,
      this.colorSender = Colors.transparent});

  final String receiver;
  final String status;
  final bool isFading;
  final List<dynamic> assigned;
  final Color? colorSender;

  @override
  State<AnimatedReceiver> createState() => _AnimatedReceiverState();
}

class _AnimatedReceiverState extends State<AnimatedReceiver>
    with SingleTickerProviderStateMixin {
  Animatable<Color?> bgColor(Color color) {
    return TweenSequence<Color?>([
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.white, end: color), weight: 1.0),
      TweenSequenceItem(
          tween: ColorTween(begin: color, end: Colors.white), weight: 1.0),
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.white, end: color), weight: 1.0),
      TweenSequenceItem(
          tween: ColorTween(begin: color, end: Colors.white), weight: 1.0),
    ]);
  }

  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
              margin: const EdgeInsets.only(right: 50),
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(3.sp),
                decoration: BoxDecoration(
                    color: iosBgColor(widget.colorSender!),
                    borderRadius: BorderRadius.circular(6.r)),
                child: Text(
                  (widget.status == "Assigned")
                      ? "${AppLocalizations.of(context)!.to} ${widget.assigned.last}"
                      : (widget.receiver == '')
                          ? ''
                          : "${AppLocalizations.of(context)!.by} ${widget.receiver}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: fullWidth < maxWidth ? 14.sp : 14,
                    letterSpacing: -0.5.sp,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
            ));
  }
}

Color iosBgColor(Color color) {
  return color;
}
