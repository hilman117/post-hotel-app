// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/settings/setting_provider.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:post_app/fireabase_service/firebase_auth.dart';
import 'package:post_app/fireabase_service/firebase_update_data.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class ChangePasswordController with ChangeNotifier {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _user = Get.put(CUser());
  FirebaseUpdateData _update = FirebaseUpdateData();
  FirebaseAuthService _auth = FirebaseAuthService();

  String currentPass = "";
  void checkCurrentPassword(String currPassword) {
    currentPass = currPassword;
    notifyListeners();
  }

  String newPass = "";
  void checkNewPassword(String newOne) {
    newPass = newOne;
    notifyListeners();
  }

  String conPass = "";
  void checkConPassword(String confirm) {
    conPass = confirm;
    notifyListeners();
  }

  Future changePassword(BuildContext context) async {
    final setting = Provider.of<SettingProvider>(context, listen: false);
    try {
      loading(context);
      await _auth.changePassword(newPass);
      await _update.updateProfile(password: newPass, email: _user.data.email!);
      List<String> list = List<String>.from(box!.get("subscribetion"));
      for (var i = 0; i < list.length; i++) {
        Notif().unsubcribeTopic(list[i]);
      }
      box!.clear();
      await setting.signOut(context);

      SessionsUser.clear();
      Fluttertoast.showToast(msg: "Change Password success");
      newPass = "";
      currentPass = "";
      conPass = "";
      newPassword.clear();
      currentPassword.clear();
      confirmPassword.clear();
      Navigator.of(context).pop();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }
}
