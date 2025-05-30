import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/core.dart';
import 'package:post_app/global_function.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../../chatroom_controller.dart';
import '../../../../pop_up_menu/pop_up_menu_provider.dart';

class SendAndMoreButton extends StatelessWidget {
  final String oldTime;
  final String oldDate;
  final TaskModel task;
  final ScrollController scroll;
  const SendAndMoreButton({
    super.key,
    required this.oldTime,
    required this.oldDate,
    required this.scroll,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final bilingual = AppLocalizations.of(context);
    return Consumer<ChatRoomController>(
        builder: (context, value, child) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            switchOutCurve: Curves.easeInSine,
            child: value.imagesList.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: fullWidth < maxWidth ? 13.sp : 13),
                    child: InkWell(
                      splashColor: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        if (Provider.of<GlobalFunction>(context, listen: false)
                                .hasInternetConnection ==
                            true) {
                          // Provider.of<ChatRoomController>(context,
                          //         listen: false)
                          //     .sendComment(context, scroll, true, task,
                          //         task.typeReport!);
                        } else {
                          Provider.of<GlobalFunction>(context, listen: false)
                              .noInternet(bilingual!
                                  .noInternetPleaseCheckYourConnection);
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: theme.primaryColor,
                        child: Icon(
                          Icons.send_rounded,
                          size: fullWidth < maxWidth ? 30.sp : 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: fullWidth < maxWidth ? 18.sp : 18),
                    child: InkWell(
                      splashColor: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                      onTap: value.status == "Hold"
                          ? () => Provider.of<PopUpMenuProvider>(context,
                                  listen: false)
                              .resumeFunction(context, task.id!,
                                  task.emailSender!, task.location!)
                          : () => Provider.of<PopUpMenuProvider>(context,
                                  listen: false)
                              .holdFunction(context, task.id!,
                                  task.emailSender!, task.location!),
                      child: value.status == "Hold"
                          ? Tooltip(
                              message: "to continue the task",
                              child: Icon(
                                Icons.play_arrow,
                                color: theme.primaryColor,
                                size: fullWidth < maxWidth ? 30.sp : 30,
                              ),
                            )
                          : Tooltip(
                              message: "to change status to Hold",
                              child: Icon(
                                Icons.pause,
                                color: theme.primaryColor,
                                size: fullWidth < maxWidth ? 30.sp : 30,
                              ),
                            ),
                    ),
                  )));
  }
}
