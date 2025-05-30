import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:get/get.dart';

class AnimatedReceiver extends StatefulWidget {
  const AnimatedReceiver(
      {super.key,
      required this.receiver,
      required this.status,
      required this.assigned,
      required this.isFading});

  final String receiver;
  final String status;
  final bool isFading;
  final List<dynamic> assigned;

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
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
              alignment: Alignment.centerRight,
              width: Get.width * 0.43,
              child: Container(
                color: widget.isFading == true
                    ? bgColor(widget.status != 'Accepted'
                            ? Colors.blue
                            : Colors.green)
                        .evaluate(AlwaysStoppedAnimation(_controller.value))
                    : Colors.white,
                child: Text(
                  (widget.status == "Assigned")
                      ? "${AppLocalizations.of(context)!.to} ${widget.assigned.last}"
                      : (widget.receiver == '')
                          ? ''
                          : "${AppLocalizations.of(context)!.by} ${widget.receiver}",
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                ),
              ),
            ));
  }
}
