// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_app/Screens/sign_up/signup.dart';
import 'package:post_app/core.dart';
import 'package:post_app/fireabase_service/firebase_read_data.dart';

import '../../common_widget/loading.dart';
import '../../controller/c_user.dart';
import '../../fireabase_service/firebase_auth.dart';
import '../../main.dart';
import '../sign_in/signin.dart';

class SettingProvider with ChangeNotifier {
  final user = Get.put(CUser());
  final readData = FirebaseReadData();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? get images => _image;
  String _imageUrl = "";
  String get imageUrl => _imageUrl;
  String imageName = '';

  changeImageProfile(String newImage) {
    _imageUrl = newImage;
    notifyListeners();
  }

  Future<void> selectImage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source, imageQuality: 30);
    _image = File(image!.path);
    imageName = image.name;
    if (imageName != '') {
      _isLoading = true;
      notifyListeners();
      String imageExtension = imageName.split('.').last;
      final ref = FirebaseStorage.instance.ref(
          "${user.data.hotelid}/${user.data.uid! + DateTime.now().toString()}.$imageExtension");
      await ref.putFile(_image!);
      _imageUrl = await ref.getDownloadURL();
      notifyListeners();
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.data.email!)
        .update({
      "profileImage": _imageUrl,
    });
    changeImageProfile(_imageUrl);
    await box!.put('fotoProfile', _imageUrl);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> onDuty(bool value) async {
    await box!.putAll({'isOnDuty': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'isOnDuty': value});
    notifyListeners();
  }

  Future<void> getNotifWhenAccepted(bool value) async {
    await box!.putAll({'ReceiveNotifWhenAccepted': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'ReceiveNotifWhenAccepted': value});
    notifyListeners();
  }

  Future<void> getNotifWhenClose(bool value) async {
    await box!.putAll({'ReceiveNotifWhenClose': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'ReceiveNotifWhenClose': value});
    notifyListeners();
  }

  Future<void> allowNotifChat(bool value) async {
    await box!.putAll({'sendChatNotif': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'sendChatNotif': value});
    notifyListeners();
  }

  Future<void> allowPopUpNotif(bool value) async {
    await box!.putAll({'popUpNotif': value});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'popUpNotif': value});
    notifyListeners();
  }

  bool? _getDutyStatus;
  bool? get getDutyStatus => _getDutyStatus;
  bool getAcceptedNotifStatus = false;
  bool getCloseNotifStatus = false;
  bool getAllowNotifStatus = false;
  bool getPopUpNotifStatus = true;
  Future<void> getOnDutyValue() async {
    var result = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .get();
    _getDutyStatus = result.data()!['isOnDuty'];
    getAcceptedNotifStatus = result.data()!['ReceiveNotifWhenAccepted'];
    getCloseNotifStatus = result.data()!['ReceiveNotifWhenClose'];
    getAllowNotifStatus = result.data()!['sendChatNotif'];
    getPopUpNotifStatus = result.data()!["popUpNotif"] ?? false;
    notifyListeners();
  }

  void changeDutyStatus(bool value) {
    _getDutyStatus = value;
    box!.putAll({'dutyStatus': value});
    notifyListeners();
  }

  UserDetails? userProfile;
  Future<void> signOut(BuildContext context) async {
    loading(context);

    try {
      // FirebaseMessaging.instance
      //     .unsubscribeFromTopic(user.data.department!.removeAllWhitespace);
      List<String> list = List<String>.from(box!.get("subscribetion"));
      print(list);
      for (var topic in list) {
        await Notif().unsubcribeTopic(topic);
        print("unsubscribe from topic $topic");
      }
      SessionsUser.clear();
      box!.clear();
      await auth.signOut();
      bool isLoggedIn = await FirebaseAuthService.isLoggedIn();
      if (!isLoggedIn) {
        Navigator.pop(context);
        Get.offAll(() => const SignIn(), transition: Transition.leftToRight);
      }
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: "Something Wrong!",
          textColor: Colors.red,
          backgroundColor: Colors.grey.shade200);
    }
    notifyListeners();
  }
}
