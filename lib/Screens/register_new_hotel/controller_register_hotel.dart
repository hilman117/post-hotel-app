import 'dart:math';

import 'package:acronym/acronym.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/extensions.dart';
import 'package:post_app/variable.dart';

class ControllerRegisterHotel with ChangeNotifier {
  String deptIcon = "";
  String domainHotelEmail = "";
  bool isSelected = false;

  void selectIcon(String icon) {
    deptIcon = icon;
    isSelected = true;
    notifyListeners();
  }

  void hotelDomain(String domain) {
    domainHotelEmail = domain;
    notifyListeners();
  }

  List<String> userColor = [
    "0xFFB71C1C",
    "0xFF0D47A1",
    "0xFF1B5E20",
    "0xFF212121",
    "0xff283593",
    "0xff1565C0",
    "0xff00838F",
    "0xff00695C",
    "0xff2E7D32",
    "0xff9E9D24",
    "0xffF9A825",
    "0xffEF6C00",
    "0xff78909C"
  ];

  String deptCode = "";
  getDeptCode(String dept) {
    var words = dept.split(" ");
    if (words.length < 2 && dept == "Housekeeping") {
      deptCode = dept.toAcronym(splitSyllables: true);
      notifyListeners();
    } else if (words.length > 1) {
      deptCode = dept.toAcronym(stopWords: []);
      notifyListeners();
    } else {
      deptCode = dept.substring(0, 3);
      notifyListeners();
    }
    notifyListeners();
  }

  Future registerNewHotel(
    BuildContext context,
    TextEditingController hotelName,
    TextEditingController domainHotel,
    TextEditingController adminName,
    TextEditingController position,
    TextEditingController adminEmail,
    TextEditingController deptName,
    TextEditingController hotelId,
  ) async {
    loading(context);
    var color = userColor..shuffle();
    int index = Random().nextInt(userColor.length);
    // getDeptCode(deptName.text);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: adminEmail.text.toLowerCase(), password: "123456");
    await FirebaseFirestore.instance
        .collection(hotelCollection)
        .doc(hotelName.text)
        .set({
      "hotelName": hotelName.text,
      "telNumber": "",
      "address": "",
      "isChangePasswordAllow": false,
      "hotelid": "",
      "hotelImage": "",
      "deptToStoreLF": "",
      "domain": "",
      "createdAt": DateTime.now().toIso8601String(),
      "location": [],
      "userGroup": [],
      "departments": []
    });
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(adminEmail.text.toLowerCase() + domainHotelEmail.toLowerCase())
        .set({
      "userColor": color[index],
      "email": adminEmail.text.toLowerCase(),
      "name": adminName.text.toTitleCase(),
      "password": "123456",
      "hotelid": hotelId.text.toString().toTitleCase(),
      "uid": adminEmail.text.toLowerCase(),
      "position": "Admin",
      'isDashboardAllow': false,
      'isAllowLF': false,
      "hotel": hotelName.text.toTitleCase(),
      "location": "",
      "profileImage": "",
      "ReceiveNotifWhenAccepted": true,
      "ReceiveNotifWhenClose": true,
      "acceptRequest": 0,
      "closeRequest": 0,
      "createRequest": 0,
      'sendChatNotif': true,
      "isOnDuty": true,
      "isActive": true,
      "department": "",
      "accountType": "Administrator",
      "token": "",
      "userGroup": []
    }).whenComplete(() {
      hotelName.clear();
      domainHotel.clear();
      adminEmail.clear();
      adminName.clear();
      position.clear();
      deptName.clear();
      domainHotelEmail = "";
      deptIcon = "";
      isSelected = false;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    Get.back();
  }
}
