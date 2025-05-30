// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'Screens/settings/setting_provider.dart';
import 'controller/c_user.dart';

class GlobalFunction with ChangeNotifier {
  final user = Get.put(CUser());
  bool isSplashShowed = false;
  //check internet connection
  bool _hasInternetConnection = true;
  bool get hasInternetConnection => _hasInternetConnection;
  Future checkInternetConnetction(String message) async {
    InternetConnectionChecker.instance.onStatusChange
        .listen((statusConnection) {
      final isConnected =
          statusConnection == InternetConnectionStatus.connected;
      _hasInternetConnection = isConnected;
      // ignore: avoid_print
      if (isConnected) {
        isSplashShowed = true;
      }
      notifyListeners();
      if (_hasInternetConnection == false) {
        noInternet(message);
      }
    });
  }

  Future<bool?> noInternet(String message) {
    return Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: message,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }

  // ignore: prefer_final_fields
  String _getFoto = '';
  String get getFoto => _getFoto;
  Future getPhotoProfile(BuildContext context) async {
    var fotoUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.data.email)
        .get();
    var data = fotoUser.data();
    String foto = data!['profileImage'];
    // ignore: avoid_print
    print(foto);
    // _getFoto = fotoUser.data()!['profileImage'];
    Provider.of<SettingProvider>(context, listen: false)
        .changeImageProfile(foto);
    notifyListeners();
    // ignore: avoid_print
    print("ini foto pofile nya $_getFoto");
  }

//id for tasks
  int generateUniqueId() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int randomDigits =
        Random().nextInt(10000); // Ganti 1000000 sesuai kebutuhan digit acak

    return int.parse('$timestamp$randomDigits');
  }

  //id for notifikasi
  int generateId() {
    int randomDigits =
        Random().nextInt(32); // Ganti  sesuai kebutuhan digit acak

    return int.parse('$randomDigits');
  }
}
