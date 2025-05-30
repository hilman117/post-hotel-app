import 'package:flutter/material.dart';

import '../../homescreen/widget/card_request.dart';

class SettingMenu extends StatelessWidget {
  final String menuName;
  final Widget widget;
  final VoidCallback callback;
  const SettingMenu(
      {super.key,
      required this.menuName,
      required this.widget,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? height * 0.09
            : height * 0.075,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.6,
              child: Text(
                menuName,
                style: const TextStyle(color: Colors.grey),
                overflow: TextOverflow.clip,
              ),
            ),
            widget
          ],
        ),
      ),
    );
  }
}
