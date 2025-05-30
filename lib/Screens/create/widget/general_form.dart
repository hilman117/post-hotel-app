import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:provider/provider.dart';
import 'package:post_app/l10n/app_localizations.dart';
import '../../../service/theme.dart';

Color themeColor = const Color(0xffF8CCA5);
Color cardColor = const Color(0xff475D5B);

class GeneralForm extends StatelessWidget {
  final String title;
  final String hintForm;
  final VoidCallback callback;
  final IconData icons;
  final Color colors;
  final bool isTask;
  const GeneralForm(
      {super.key,
      required this.title,
      required this.hintForm,
      required this.callback,
      required this.icons,
      required this.colors,
      required this.isTask});

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: fullWidth < maxWidth ? 8.sp : 8),
        child: Consumer<CreateRequestController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isTask != true &&
                        title == AppLocalizations.of(context)!.sendThisTo
                    ? '- - - - - - '
                    : title,
                style: TextStyle(
                    color: value.isLfReport &&
                            title == AppLocalizations.of(context)!.sendThisTo
                        ? Colors.black38
                        : theme.focusColor,
                    fontSize: fullWidth < maxWidth ? 15.sp : 15),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                // height: Get.height * 0.07,
                decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: isTask != true &&
                                  title ==
                                      AppLocalizations.of(context)!.sendThisTo
                              ? null
                              : callback,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: landscape
                                ? Get.height * 0.1
                                : Get.height * 0.06,
                            decoration: BoxDecoration(
                                border: Border.all(color: theme.canvasColor),
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Row(
                              children: [
                                isTask != true
                                    ? Expanded(
                                        child: Container(
                                            child: value.isLfReport &&
                                                    title ==
                                                        AppLocalizations.of(
                                                                context)!
                                                            .sendThisTo
                                                ? Text(
                                                    '- - - - - - - - - - - - - - - - - - -',
                                                    style: TextStyle(
                                                        color: theme.focusColor,
                                                        fontSize: 15.sp))
                                                : TextFormField(
                                                    controller: value.nameItem,
                                                    style: TextStyle(
                                                      fontSize:
                                                          fullWidth < maxWidth
                                                              ? 14.sp
                                                              : 14,
                                                      color: theme.focusColor,
                                                    ),
                                                    cursorHeight:
                                                        fullWidth < maxWidth
                                                            ? 14.sp
                                                            : 14,
                                                    cursorColor: mainColor,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    decoration: InputDecoration(
                                                        hintText: hintForm,
                                                        hintStyle: TextStyle(
                                                            color: theme
                                                                .focusColor),
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none),
                                                  )))
                                    : Text(
                                        hintForm,
                                        style:
                                            TextStyle(color: theme.focusColor),
                                      ),
                                isTask != true
                                    ? const SizedBox()
                                    : const Spacer(),
                                isTask != true &&
                                        title ==
                                            AppLocalizations.of(context)!
                                                .sendThisTo
                                    ? const SizedBox()
                                    : Icon(
                                        icons,
                                        color: isTask != true &&
                                                title ==
                                                    AppLocalizations.of(
                                                            context)!
                                                        .sendThisTo
                                            ? Colors.grey
                                            : secondary,
                                        size: 20.sp,
                                      ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
