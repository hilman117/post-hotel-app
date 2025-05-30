// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/widget/pages/lost_and_found/lost_and_found_controller.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:provider/provider.dart';
import 'package:post_app/l10n/app_localizations.dart';
import '../../chatroom_controller.dart';
import '../close_dialog.dart';
import '../image_picker.dart';
import 'widget/button_action.dart';
import 'widget/keyboard/keyboard.dart';
import 'widget/list_images_comment.dart';

class ActionArea extends StatelessWidget {
  final TaskModel task;
  final ScrollController scrollController;
  ActionArea({
    super.key,
    required this.scrollController,
    required this.task,
  });

  final user = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final app = AppLocalizations.of(context);
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Consumer<ChatRoomController>(
        builder: (context, value, child) => AnimatedSwitcher(
          switchInCurve: Curves.easeInSine,
          switchOutCurve: Curves.easeOutSine,
          duration: const Duration(seconds: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Platform.isAndroid)
                task.typeReport == "tasks"
                    ? SizedBox(
                        height: fullWidth < maxWidth ? 40.h : 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            value.status == "Close"
                                ? const SizedBox()
                                : buttonAction(context, app!.close, () {
                                    closeDialog(
                                      context,
                                      task,
                                      scrollController,
                                    );
                                  }, value.status),
                            value.status == "Close"
                                ? buttonAction(context, app!.reopen, () {
                                    // provider.reopen(
                                    //     context,
                                    //     task.id!,
                                    //     task.location!,
                                    //     task.title!,
                                    //     scrollController,
                                    //     task.sendTo!);
                                  }, value.status)
                                : buttonAction(context, app!.assign, () async {
                                    // assign(
                                    //     context,
                                    //     task.id!,
                                    //     task.emailSender!,
                                    //     task.location!,
                                    //     task.title!,
                                    //     scrollController);
                                    await provider.getDeptartementAndNames();
                                  }, value.status),
                            value.status == "Close"
                                ? const SizedBox()
                                : buttonAction(context, app.accept, () {
                                    // if (
                                    //   Provider.of<GlobalFunction>(context,
                                    //             listen: false)
                                    //         .hasInternetConnection ==
                                    //     true) {
                                    //   value.receiver == cUser.data.name
                                    //       ? Fluttertoast.showToast(
                                    //           textColor: Colors.black,
                                    //           backgroundColor: Colors.white,
                                    //           msg:
                                    //               "You have received this request")
                                    //       : provider.accept(
                                    //           context,
                                    //           task.id!,
                                    //           "${user.data.name} has accept this request",
                                    //           task.emailSender!,
                                    //           task.location!,
                                    //           task.title!,
                                    //           task.typeReport!,
                                    //           "Accepted",
                                    //           scrollController,
                                    //           task.sendTo!);
                                    // } else {
                                    //   Provider.of<GlobalFunction>(context,
                                    //           listen: false)
                                    //       .noInternet();
                                    // }
                                  }, value.status),
                          ],
                        ),
                      )
                    : buttonOnLf(
                        taskModel: task,
                        context: context,
                        scroll: scrollController,
                        email: user.data.email!),
              SizedBox(height: fullWidth < maxWidth ? 10.h : 10),
              value.status == "Close" ||
                      value.status == "Release" ||
                      value.status == "Claimed"
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: fullWidth < maxWidth ? 10.sp : 10),
                      child: keyboardChat(
                          context: context,
                          scroll: scrollController,
                          oldDate: task.setDate!,
                          oldTime: task.setTime!,
                          task: task),
                    ),
              value.imagesList.isNotEmpty
                  ? const ListImagesComment()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

Widget buttonOnLf(
    {required BuildContext context,
    required ScrollController scroll,
    required String email,
    required TaskModel taskModel}) {
  final user = Get.put(CUser());
  final controller = Provider.of<ChatRoomController>(context, listen: false);
  final theme = Theme.of(context);
  final lfController =
      Provider.of<LostAndFoundControntroller>(context, listen: false);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  if (user.data.accountType == "Dept. Admin" &&
      user.data.department == "Housekeeping") {
    return Consumer<ChatRoomController>(builder: (context, value, child) {
      if (value.status == "Release") {
        return const SizedBox();
      }
      if (value.status == "Claimed") {
        return const SizedBox();
      }
      if (value.status == "New") {
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: fullWidth < maxWidth ? 10.sp : 10),
            width: double.infinity,
            child: Consumer<ChatRoomController>(
              builder: (context, value, child) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: theme.primaryColor),
                onPressed: () async {
                  await imagePickerBottomSheet(
                      context: context,
                      height: fullWidth < maxWidth ? 700.h : 700,
                      widht: double.infinity,
                      todoIfHasImage: () async {
                        // if (value.imagesList.isNotEmpty) {
                        //   loading(context);
                        //   await controller.sendComment(context, scroll, false,
                        //       taskModel, taskModel.typeReport!);
                        //   await controller.accept(
                        //       context,
                        //       taskModel.id!,
                        //       "${user.data.name} has accept the lost and found item",
                        //       email,
                        //       taskModel.location!,
                        //       taskModel.title!,
                        //       taskModel.typeReport!,
                        //       "Accepted",
                        //       scroll,
                        //       taskModel.sendTo!);
                        //   await lfController.readLostAndFound(context);
                        //   Navigator.of(context).pop();
                        // }
                      });
                },
                child: Text(
                  "Accept",
                  style: TextStyle(
                      fontSize: fullWidth < maxWidth ? 14.sp : 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ));
      }
      return Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: fullWidth < maxWidth ? 5.sp : 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    elevation: theme.brightness == Brightness.dark ? 0 : 1),
                onPressed: () async {
                  await imagePickerBottomSheet(
                      context: context,
                      height: fullWidth < maxWidth ? 700.h : 700,
                      widht: double.infinity,
                      todoIfHasImage: () async {
                        // if (value.imagesList.isNotEmpty) {
                        //   loading(context);
                        //   await controller.sendComment(context, scroll, false,
                        //       taskModel, taskModel.typeReport!);
                        //   await controller.accept(
                        //       context,
                        //       taskModel.id!,
                        //       "${taskModel.title} has been claimed by the owner",
                        //       email,
                        //       taskModel.location!,
                        //       taskModel.title!,
                        //       taskModel.typeReport!,
                        //       "Claimed",
                        //       scroll,
                        //       taskModel.sendTo!);
                        //   await lfController.readLostAndFound(context);
                        //   Navigator.of(context).pop();
                        // }
                      });
                },
                child: const Text('Claim by guest')),
          )),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: fullWidth < maxWidth ? 5.sp : 5),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    elevation: theme.brightness == Brightness.dark ? 0 : 1),
                onPressed: () async {
                  await imagePickerBottomSheet(
                      context: context,
                      height: fullWidth < maxWidth ? 700.h : 700,
                      widht: double.infinity,
                      todoIfHasImage: () async {
                        // if (value.imagesList.isNotEmpty) {
                        //   loading(context);
                        //   await controller.sendComment(context, scroll, false,
                        //       taskModel, taskModel.typeReport!);
                        //   await controller.accept(
                        //       context,
                        //       taskModel.id!,
                        //       "${taskModel.title} has been release to the founder",
                        //       email,
                        //       taskModel.location!,
                        //       taskModel.title!,
                        //       taskModel.typeReport!,
                        //       "Release",
                        //       scroll,
                        //       taskModel.sendTo!);
                        //   await lfController.readLostAndFound(context);
                        //   Navigator.of(context).pop();
                        // }
                      });
                },
                child: const Text('Release to founder')),
          )),
        ],
      );
    });
  }
  return const SizedBox();
}
