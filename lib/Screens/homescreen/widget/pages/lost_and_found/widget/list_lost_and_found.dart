import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/chatroom/chatroom_task.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/core.dart';
import 'dart:io' show Platform;

class ListLostAndFound extends StatelessWidget {
  const ListLostAndFound({super.key, required this.list});
  final List<TaskModel> list;

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context);
    final theme = Theme.of(context);
    list.sort(
      (a, b) => b.time!.compareTo(a.time!),
    );
    return ListView.builder(
      physics: Platform.isIOS
          ? const BouncingScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: list.length,
      itemBuilder: (context, index) {
        TaskModel lf = list[index];
        String time = DateFormat("dd/MM/yy").format(lf.time!.toDate());

        return ListTile(
          onTap: () => Get.to(
              () => ChatRoomTask(
                    taskModel: lf,
                  ),
              transition: Transition.rightToLeft),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.sp),
          minVerticalPadding: 0,
          title: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: theme.cardColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 90.h,
                          width: 100.w,
                          child: Image.network(
                            lf.image!.first,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Container(
                                  height: 80.h,
                                  width: 90.w,
                                  color: theme.cardColor,
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 80.h,
                                width: 90.w,
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 130.w,
                                child: Text(
                                  lf.title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: theme.focusColor),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              SizedBox(
                                width: 130.w,
                                child: Text(
                                  lf.location!,
                                  style: TextStyle(
                                      fontSize: 18.sp, color: theme.focusColor),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              SizedBox(
                                width: 130.w,
                                child: Text(
                                  lf.sender!,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.grey),
                              ),
                              if (lf.description!.isNotEmpty)
                                SizedBox(
                                  height: 7.h,
                                ),
                              if (lf.description!.isNotEmpty)
                                SizedBox(
                                  width: 130.w.w,
                                  child: Text(
                                    lf.description!,
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Chip(
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        labelPadding: const EdgeInsets.all(0),
                        label: Container(
                          alignment: Alignment.center,
                          width: 50.w,
                          child: Text(
                            (lf.status == "New")
                                ? app!.newStatus
                                : (lf.status == "Accepted")
                                    ? app!.accepted
                                    : lf.status!,
                            style: TextStyle(
                                color: (lf.status == "Release" ||
                                        lf.status == "Claimed")
                                    ? theme.focusColor
                                    : (lf.status == "New")
                                        ? Colors.red
                                        : Colors.green,
                                fontWeight: FontWeight.normal,
                                fontSize: 11.sp,
                                fontStyle: lf.status == "Release" ||
                                        lf.status == "Claimed"
                                    ? FontStyle.italic
                                    : FontStyle.normal),
                          ),
                        ))
                  ],
                ),
              )),
        );
      },
    );
  }
}
