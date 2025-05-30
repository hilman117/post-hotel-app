// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/change_password/change_password.dart';
import 'package:post_app/Screens/settings/setting_provider.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:provider/provider.dart';

import '../../Screens/homescreen/home_controller.dart';
import '../../controller/c_user.dart';
import '../../main.dart';
import '../../pop_up_notif_controller.dart';
import '../settings/widget/log_out_dialog.dart';

class IosProfile extends StatefulWidget {
  final List<Departement> departments;
  const IosProfile({super.key, required this.departments});

  @override
  State<IosProfile> createState() => _IosProfileState();
}

class _IosProfileState extends State<IosProfile> {
  @override
  void initState() {
    final provider = Provider.of<SettingProvider>(context, listen: false);
    provider.getOnDutyValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Get.put(CUser());
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final provider = Provider.of<SettingProvider>(context, listen: false);
    final bilingual = AppLocalizations.of(context);
    return Consumer<HomeController>(builder: (context, value, child) {
      return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: SafeArea(
          child: Material(
            color: CupertinoColors.systemGroupedBackground,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              // height: 500,
              // width: 300,
              child: ListView(
                children: [
                  Consumer<HomeController>(builder: (context, value, child) {
                    return Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: fullWidth < maxWidth ? 200.h : 350,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.sp),
                            child: Container(
                              height: 80.sp,
                              width: 80.sp,
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.person,
                                size: 40.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            user.data.name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.focusColor,
                                fontSize: fullWidth < maxWidth ? 15.sp : 15),
                          ),
                          Text(
                            "${user.data.position!} ${bilingual!.workPlace} ${user.data.hotel!}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: theme.focusColor,
                                fontSize: fullWidth < maxWidth ? 12.sp : 12),
                          ),
                        ],
                      ),
                    );
                  }),
                  CupertinoListSection.insetGrouped(
                    header: Text(
                      bilingual!.account,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fullWidth < maxWidth ? 15.sp : 15),
                    ),
                    children: [
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.group,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.userGroup,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        trailing: Expanded(
                          child: Text(
                            user.data.userGroup!.join(","),
                            style: TextStyle(
                                fontSize: fullWidth < maxWidth ? 13.sp : 13),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        onTap: () {
                          // navigate to profile
                        },
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.archivebox,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.receiver,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        trailing: Builder(builder: (context) {
                          List<String> receiverFor = [];

                          for (var index = 0;
                              index < widget.departments.length;
                              index++) {
                            var receivingUsers =
                                widget.departments[index].receivingUser;
                            if (receivingUsers != null) {
                              for (var i = 0; i < receivingUsers.length; i++) {
                                var data =
                                    receivingUsers[i]["receiver"] as List?;
                                if (data != null &&
                                    data.contains(user.data.name)) {
                                  receiverFor.add(
                                      widget.departments[index].departement!);
                                }
                              }
                            }
                          }
                          return Expanded(
                            child: Text(
                              receiverFor.join(","),
                              style: TextStyle(
                                  fontSize: fullWidth < maxWidth ? 13.sp : 13),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.right,
                            ),
                          );
                        }),
                        onTap: () {
                          // navigate to profile
                        },
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.at_circle,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.accountType,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        trailing: Expanded(
                          child: Text(
                            user.data.accountType!,
                            style: TextStyle(
                                fontSize: fullWidth < maxWidth ? 13.sp : 13),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        onTap: () {
                          // navigate to profile
                        },
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.globe,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.allowToOpenOnWeb,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        trailing: Icon(
                          user.data.isDashboardAllow!
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.xmark_circle_fill,
                          size: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.viewfinder,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.allowToAccessLF,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        trailing: Icon(
                          user.data.isAllowLF!
                              ? CupertinoIcons.check_mark_circled_solid
                              : CupertinoIcons.xmark_circle_fill,
                          size: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.lock,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.changePassword,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const ChangePassword(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  CupertinoListSection.insetGrouped(
                    header: Text(
                      bilingual.notifications,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fullWidth < maxWidth ? 15.sp : 15),
                    ),
                    children: [
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.captions_bubble,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.popUpNotification,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        subtitle: Text(
                          bilingual.popUpWindowForEveryNewRequest,
                          style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 11.sp : 11,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.7,
                          child: Consumer<SettingProvider>(
                              builder: (context, value, child) {
                            return CupertinoSwitch(
                                value: box!.get('popUpNotif') ??
                                    value.getPopUpNotifStatus,
                                onChanged: (bool value) async {
                                  bool isGranted = await FlutterOverlayWindow
                                      .isPermissionGranted();
                                  if (!isGranted) {
                                    PopUpNotifController.permissionPopUpDialog(
                                        context);
                                  } else {
                                    provider.allowPopUpNotif(value);
                                  }
                                });
                          }),
                        ),
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.today_fill,
                          size: 20.sp,
                        ),
                        title: Text(
                          '${bilingual.onDuty}?',
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        subtitle: Text(
                          bilingual.switchOffAllKindOfNotifications,
                          style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 11.sp : 11,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.7,
                          child: Consumer<SettingProvider>(
                              builder: (context, value, child) {
                            return CupertinoSwitch(
                              value:
                                  box!.get('isOnDuty') ?? value.getDutyStatus,
                              onChanged: (bool value) {
                                provider.onDuty(value);
                              },
                            );
                          }),
                        ),
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.check_mark_circled,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.notifiedAcceptedRequest,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        subtitle: Text(
                          bilingual.getNotifiedWhenYourRequestIsAccepted,
                          style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 11.sp : 11,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.7,
                          child: Consumer<SettingProvider>(
                              builder: (context, value, child) {
                            return CupertinoSwitch(
                              value: box!.get('ReceiveNotifWhenAccepted') ??
                                  value.getAcceptedNotifStatus,
                              onChanged: (bool value) {
                                provider.getNotifWhenAccepted(value);
                              },
                            );
                          }),
                        ),
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.bin_xmark,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.notifiedCloseRequest,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        subtitle: Text(
                          bilingual.getNotifiedWhenYourRequestIsClosed,
                          style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 11.sp : 11,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.7,
                          child: Consumer<SettingProvider>(
                              builder: (context, value, child) {
                            return CupertinoSwitch(
                              value: box!.get('ReceiveNotifWhenClose') ??
                                  value.getCloseNotifStatus,
                              onChanged: (bool value) {
                                provider.getNotifWhenClose(value);
                              },
                            );
                          }),
                        ),
                      ),
                      CupertinoListTile(
                        leading: Icon(
                          CupertinoIcons.chat_bubble,
                          size: 20.sp,
                        ),
                        title: Text(
                          bilingual.chatNotification,
                          style: TextStyle(
                              fontSize: fullWidth < maxWidth ? 13.sp : 13),
                        ),
                        subtitle: Text(
                          bilingual.getNotifiedForNewComment,
                          style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 11.sp : 11,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.7,
                          child: Consumer<SettingProvider>(
                              builder: (context, value, child) {
                            return CupertinoSwitch(
                              value: box!.get('sendChatNotif') ??
                                  value.getAllowNotifStatus,
                              onChanged: (bool value) {
                                provider.allowNotifChat(value);
                              },
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  CupertinoListSection.insetGrouped(
                    children: [
                      CupertinoListTile(
                          title: Text(
                            bilingual.logOut,
                            style: TextStyle(
                                color: CupertinoColors.systemRed,
                                fontSize: 13.sp),
                          ),
                          onTap: () => logoutDialog(context)),
                    ],
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [

              //     Container(
              //       padding: EdgeInsets.all(10.sp),
              //       decoration: BoxDecoration(
              //           color: theme.cardColor,
              //           borderRadius: BorderRadius.circular(10.r)),
              //       child: Column(
              //         children: [
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Container(
              //                       padding: EdgeInsets.all(2.sp),
              //                       decoration: BoxDecoration(
              //                           borderRadius:
              //                               BorderRadiusDirectional.circular(3.r),
              //                           color: Colors.red),
              //                       child: Icon(
              //                         CupertinoIcons.house_alt_fill,
              //                         color: Colors.white,
              //                         size: fullWidth < maxWidth ? 18.sp : 18,
              //                       )),
              //                   SizedBox(
              //                     width: fullWidth < maxWidth ? 10.sp : 10,
              //                   ),
              //                   Text(
              //                     user.data.hotel!,
              //                     style: TextStyle(
              //                         letterSpacing: -0.5,
              //                         fontWeight: FontWeight.w400,
              //                         color: theme.focusColor,
              //                         fontSize:
              //                             fullWidth < maxWidth ? 15.sp : 15),
              //                   ),
              //                 ],
              //               ),
              //               const Divider()
              //             ],
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Container(
              //                       padding: EdgeInsets.all(2.sp),
              //                       decoration: BoxDecoration(
              //                           borderRadius:
              //                               BorderRadiusDirectional.circular(3.r),
              //                           color: Colors.blue),
              //                       child: Icon(
              //                         CupertinoIcons.person,
              //                         color: Colors.white,
              //                         size: fullWidth < maxWidth ? 18.sp : 18,
              //                       )),
              //                   SizedBox(
              //                     width: fullWidth < maxWidth ? 10.sp : 10,
              //                   ),
              //                   Text(
              //                     user.data.name!,
              //                     style: TextStyle(
              //                         letterSpacing: -0.5,
              //                         fontWeight: FontWeight.w400,
              //                         color: theme.focusColor,
              //                         fontSize:
              //                             fullWidth < maxWidth ? 15.sp : 15),
              //                   ),
              //                 ],
              //               ),
              //               const Divider()
              //             ],
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Container(
              //                       padding: EdgeInsets.all(2.sp),
              //                       decoration: BoxDecoration(
              //                           borderRadius:
              //                               BorderRadiusDirectional.circular(3.r),
              //                           color: Colors.green),
              //                       child: Icon(
              //                         CupertinoIcons.group_solid,
              //                         color: Colors.white,
              //                         size: fullWidth < maxWidth ? 18.sp : 18,
              //                       )),
              //                   SizedBox(
              //                     width: fullWidth < maxWidth ? 10.sp : 10,
              //                   ),
              //                   Text(
              //                     user.data.department!,
              //                     style: TextStyle(
              //                         letterSpacing: -0.5,
              //                         fontWeight: FontWeight.w400,
              //                         color: theme.focusColor,
              //                         fontSize:
              //                             fullWidth < maxWidth ? 15.sp : 15),
              //                   ),
              //                 ],
              //               ),
              //               const Divider()
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       height: fullWidth < maxWidth ? 20.h : 20,
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      );
    });
  }
}

// Panggil fungsi ini ketika Anda ingin menampilkan bottom sheet
