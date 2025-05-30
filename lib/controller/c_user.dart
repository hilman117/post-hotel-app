import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/models/user.dart';

class CUser extends GetxController {
  final Rx<UserDetails> _data = UserDetails().obs;
  UserDetails get data => _data.value;
  void setData(UserDetails n) => _data.value = n;
}

class UserData extends ChangeNotifier {
  UserDetails _data = UserDetails();
  UserDetails get data => _data;
  void saveModelData(UserDetails n) {
    _data = n;
    notifyListeners();
  }
}
