import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/service/theme.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../card_request.dart';

class SearchHome extends StatelessWidget {
  const SearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        // width: width * 0.65,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? height * 0.07
            : height * 0.04,
        decoration: BoxDecoration(
            color: mainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4)),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller.text,
          cursorColor: mainColor,
          onChanged: (text) {
            controller.getInputTextSearch(text);
          },
          decoration: InputDecoration(
              // isDense: true,
              contentPadding: EdgeInsets.only(bottom: height * 0.017),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                size: 20,
                color: Colors.grey,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 35,
                minHeight: 35,
              ),
              hintText: AppLocalizations.of(context)!.search,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
