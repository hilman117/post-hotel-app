import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/settings/setting_provider.dart';
import 'package:post_app/Screens/settings/widget/log_out_dialog.dart';
import 'package:post_app/Screens/settings/widget/profile_user.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'widget/setting_menu.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    final provider = Provider.of<SettingProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<SettingProvider>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                const ProfileUser(),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!
                        .doYouWantToAcceptNotificationWhenYourRequestAreAccepted,
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) async {},
                      value: box!.get('ReceiveNotifWhenAccepted') ?? true,
                    )),
                const Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!
                        .doYouWantToAcceptNotificationWhenYourRequestAreClose,
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) {},
                      value: box!.get('ReceiveNotifWhenClose') ?? true,
                    )),
                const Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!
                        .doYouWantToSendNotificationWhenYouUpdateChat,
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) {},
                      value: box!.get('sendNotification'),
                    )),
                const Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: "${AppLocalizations.of(context)!.onDuty}?",
                    widget: Switch.adaptive(
                      activeColor: mainColor,
                      activeTrackColor: mainColor,
                      inactiveTrackColor: Colors.orange,
                      onChanged: (bool bool) async {
                        provider.onDuty(bool);
                        Provider.of<SettingProvider>(context, listen: false)
                            .changeDutyStatus(bool);
                      },
                      value: false,
                    )),
                const Divider(),
                SettingMenu(
                    callback: () {},
                    menuName: AppLocalizations.of(context)!.changePassword,
                    widget: Icon(Icons.arrow_forward_ios, color: mainColor)),
                const Divider(),
                SettingMenu(
                    callback: () {
                      logoutDialog(context);
                    },
                    menuName: AppLocalizations.of(context)!.logOut,
                    widget: Icon(
                      Icons.logout_rounded,
                      color: mainColor,
                    )),
                const Divider(),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    "${cUser.data.hotelid}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
