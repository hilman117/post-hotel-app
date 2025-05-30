import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

import '../../global_function.dart';
import '../../models/tasks.dart';
import '../chatroom/chatroom_controller.dart';
import '../chatroom/widget/action_area/widget/list_images_comment.dart';
import '../chatroom/widget/close_dialog.dart';
import 'ios_image_picker.dart';
import 'ios_modal_pop_up.dart';

class IosActionArea extends StatefulWidget {
  const IosActionArea({
    super.key,
    required this.task,
    required this.isTask,
    required this.keyboardFocus,
  });
  final TaskModel task;
  final bool isTask;
  final FocusNode keyboardFocus;

  @override
  State<IosActionArea> createState() => _IosActionAreaState();
}

class _IosActionAreaState extends State<IosActionArea> {
  ScrollController scroll = ScrollController();
  final user = Get.put(CUser());
  TextEditingController commentText = TextEditingController();

  @override
  void dispose() {
    commentText.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final event = Provider.of<ChatRoomController>(context, listen: false);
    final app = AppLocalizations.of(context);
    final provider = Provider.of<ChatRoomController>(context, listen: false);
    return Consumer<ChatRoomController>(
      builder: (context, value, child) {
        if (value.status == "Close" ||
            value.status == "Claimed" ||
            value.status == "Release") {
          return Center(
            child: CupertinoButton(
                child: Text(app!.reopen),
                onPressed: () => event.reopen(context, widget.task, scroll)),
          );
        }
        return Container(
            // height: fullWidth < maxWidth ? 50.h : 50,
            // padding: EdgeInsets.only(top: fullWidth < maxWidth ? 15.sp : 15),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              // boxShadow: const [
              //   BoxShadow(color: Colors.grey, offset: Offset(-1, -1))
              // ]
            ),
            child: Column(
              children: [
                Consumer<ChatRoomController>(builder: (context, value, child) {
                  if (value.isLoadImageComment) {
                    return Lottie.asset("images/loadimage.json", height: 50.sp);
                  } else if (value.imagesList.isNotEmpty) {
                    return const ListImagesComment();
                  }
                  return const SizedBox();
                }),
                if (value.imagesList.isNotEmpty)
                  SizedBox(
                    height: 5.h,
                  ),
                if (widget.isTask)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.sp),
                    height: 30.h,
                    child: Row(
                      children: [
                        Expanded(
                            child: CupertinoButton(
                          borderRadius: BorderRadius.circular(50.r),
                          padding: const EdgeInsets.all(0),
                          color: theme.primaryColor,
                          child: Text(
                            widget.isTask ? app!.close : "Release",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          onPressed: () {
                            closeDialog(
                              context,
                              widget.task,
                              scroll,
                            );
                          },
                        )),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                            child: CupertinoButton(
                          borderRadius: BorderRadius.circular(50.r),
                          padding: const EdgeInsets.all(0),
                          color: theme.primaryColor,
                          child: Text(
                            widget.isTask ? app!.assign : "Claim",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            showAssignModalSheet(context, widget.task, scroll);
                            await provider.getDeptartementAndNames();
                          },
                        )),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                            child: CupertinoButton(
                          borderRadius: BorderRadius.circular(50.r),
                          padding: const EdgeInsets.all(0),
                          color: theme.primaryColor,
                          child: Text(
                            app!.accept,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          onPressed: () async {
                            if (Provider.of<GlobalFunction>(context,
                                        listen: false)
                                    .hasInternetConnection ==
                                true) {
                              if (value.receiver == user.data.name) {
                                Fluttertoast.showToast(
                                    textColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    msg: "You have received this request");
                              } else {
                                await provider.accept(
                                  context,
                                  widget.task,
                                  "${user.data.name} has accept this request",
                                  "tasks",
                                  "Accepted",
                                  scroll,
                                );
                              }
                            } else {
                              Provider.of<GlobalFunction>(context,
                                      listen: false)
                                  .noInternet(
                                      app.noInternetPleaseCheckYourConnection);
                            }
                          },
                        )),
                        // CupertinoButton(  //FITUR INI NANTI TAMBAHKAN SETELAH RILIS, SKRNG SKIP DULU
                        //     padding: EdgeInsets.only(right: 20.w, left: 10.w),
                        //     child: const Icon(Icons.more_vert_rounded),
                        //     onPressed: () => showActionTask(
                        //         context, scroll, widget.task, widget.isTask))
                      ],
                    ),
                  ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        constraints:
                            BoxConstraints(maxHeight: 20.h, maxWidth: 20.w),
                        onPressed: () => iosImagePicker(context, false),
                        icon: Icon(
                          CupertinoIcons.camera_fill,
                          size: 20.sp,
                          color: theme.primaryColor,
                        )),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  fullWidth < maxWidth ? 20.r : 20)),
                          child: CupertinoTextField(
                            autofocus: false,
                            // focusNode: widget.keyboardFocus,
                            style: TextStyle(color: theme.focusColor),
                            placeholder: app!.typeHere,
                            controller: commentText,
                            onChanged: (value) {
                              provider.typing(value);
                            },
                            minLines: 1,
                            maxLines: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(
                                  fullWidth < maxWidth ? 22.r : 22),
                            ),
                            suffix:
                                Consumer2<ChatRoomController, HomeController>(
                                    builder: (context, value, value2, child) {
                              return InkWell(
                                onTap: () async {
                                  if (commentText.text.isNotEmpty ||
                                      value.imagesList.isNotEmpty) {
                                    if (Provider.of<GlobalFunction>(context,
                                                listen: false)
                                            .hasInternetConnection ==
                                        true) {
                                      await event.sendComment(
                                          context,
                                          scroll,
                                          commentText,
                                          true,
                                          widget.task,
                                          widget.task.typeReport!,
                                          value2.listDepartement!);
                                    } else {
                                      Provider.of<GlobalFunction>(context,
                                              listen: false)
                                          .noInternet(app
                                              .noInternetPleaseCheckYourConnection);
                                    }
                                  } else {
                                    null;
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    padding: EdgeInsets.all(3.sp),
                                    margin: EdgeInsets.all(3.sp),
                                    alignment: Alignment.center,
                                    height: 30.sp,
                                    width: 30.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: commentText.text.isNotEmpty ||
                                              value.imagesList.isNotEmpty
                                          ? theme.primaryColor
                                          : CupertinoColors.inactiveGray,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.paperplane_fill,
                                      color: commentText.text.isNotEmpty ||
                                              value.imagesList.isNotEmpty
                                          ? Colors.white
                                          : Colors.grey.shade50,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )),
                    ),
                    SizedBox(
                      width: 20.sp,
                    )
                  ],
                ),
              ],
            ));
      },
    );
  }
}

showActionTask(BuildContext context, ScrollController scroll, TaskModel task,
    bool isTask) {
  final theme = Theme.of(context);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  final user = Get.put(CUser());
  final app = AppLocalizations.of(context);
  final provider = Provider.of<ChatRoomController>(context, listen: false);

  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () async {
                // provider.
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.pause_circle, color: theme.primaryColor),
                  SizedBox(
                    width: 3.sp,
                  ),
                  Text(
                    app!.onHold,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              )),
          CupertinoActionSheetAction(
              onPressed: () async {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.play, color: theme.primaryColor),
                  SizedBox(
                    width: 3.sp,
                  ),
                  Text(
                    app.resume,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              )),
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.location, color: theme.primaryColor),
                  SizedBox(
                    width: 3.sp,
                  ),
                  Text(
                    app.editLocation,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              )),
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.text_justifyleft,
                      color: theme.primaryColor),
                  SizedBox(
                    width: 3.sp,
                  ),
                  Text(
                    app.editTitle,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              )),
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.alarm, color: theme.primaryColor),
                  SizedBox(
                    width: 3.sp,
                  ),
                  Text(
                    app.deleteDueDate,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              )),
        ],
      );
    },
  );
}
