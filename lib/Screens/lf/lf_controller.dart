// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:post_app/Screens/sign_up/signup.dart';
import 'package:uuid/uuid.dart';

import '../../controller/c_user.dart';
import '../../main.dart';


class ReportLFController with ChangeNotifier {
  final user = Get.put(CUser());
  String _receiveByFounder = '';
  String get receiveByFounder => _receiveByFounder;

  String _statusItem = '';
  String get statusItem => _statusItem;

  String imageName = '';
  final ImagePicker _picker = ImagePicker();
  XFile? _fromCamera;
  XFile? get fromCamera => _fromCamera;
  final List<XFile?> _imageList = [];
  List<XFile?> get imagesList => _imageList;
  final List<String> _imageUrl = [];
  List<String> get imageUrls => _imageUrl;
  Future<void> selectImage(ImageSource source) async {
    List<XFile?> selectedImage = await _picker.pickMultiImage(imageQuality: 30);
    if (selectedImage.isNotEmpty) {
      _imageList.addAll(selectedImage);
      notifyListeners();
      print(_imageList.length);
    }
  }

  Future<void> selectFromCamera() async {
    _fromCamera =
        await _picker.pickImage(imageQuality: 30, source: ImageSource.camera);
    if (_fromCamera != null) {
      _imageList.add(_fromCamera);
      print(_imageList.length);
    }
    notifyListeners();
  }

  void removeSingleImage(int index) {
    _imageList.removeAt(index);
    imageName = '';
    notifyListeners();
  }

  void scrollMaxExtend(ScrollController scroll) {
    if (scroll.hasClients) {
      final position = scroll.position.minScrollExtent;
      scroll.animateTo(position,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  bool _isTyping = false;
  bool get isTypping => _isTyping;
  String _value = '';
  String get nilai => _value;
  void typing(String value) {
    _value = value;
    if (_value.isNotEmpty) {
      _isTyping = true;
    } else {
      _isTyping = false;
    }
    notifyListeners();
  }

  bool _isImageLoad = false;
  bool get isImageLoad => _isImageLoad;
  void loadimage(bool newValue) {
    _isImageLoad = newValue;
    notifyListeners();
  }

  TextEditingController commentBody = TextEditingController();
  void sendCommentForLostAndFound(
      String taskId,
      String location,
      String title,
      ScrollController scroll,
      String reportCreator,
      String creatorEmail,
      TextEditingController text) async {
    notifyListeners();
    _imageUrl.clear();
    if (_imageList.isNotEmpty) {
      _isImageLoad = true;
      _imageList.forEach((element) async {
        String imageExtension = imageName.split('.').last;
        notifyListeners();
        final ref = FirebaseStorage.instance.ref(
            "${user.data.hotelid}/${user.data.uid} + ${DateTime.now().toString()}.$imageExtension");
        await ref.putFile(File(element!.path));
        await ref.getDownloadURL().then((value) async {
          _imageUrl.add(value);
          notifyListeners();
          print("ini image list sebelum di upload ${_imageList.length}");
          print(
              "ini image list stelah di upload di upload ${_imageUrl.length}");
          print("$_imageUrl");
          if (_imageUrl.length == _imageList.length) {
            _imageList.clear();
            await FirebaseFirestore.instance
                .collection('Hotel List')
                .doc(user.data.hotelid)
                .collection('lost and found')
                .doc(taskId)
                .update({
              'comment': FieldValue.arrayUnion([
                {
                  "timeSent": DateTime.now(),
                  'accepted': "",
                  'commentBody': text.text,
                  'commentId': const Uuid().v4(),
                  'imageComment': _imageUrl,
                  'sender': user.data.name,
                  'senderemail': auth.currentUser!.email,
                  'time': DateTime.now().toString(),
                }
              ])
            });
          }
        });
      });
      _isImageLoad = false;
    } else {
      await FirebaseFirestore.instance
          .collection('Hotel List')
          .doc(user.data.hotelid)
          .collection('lost and found')
          .doc(taskId)
          .update({
        'comment': FieldValue.arrayUnion([
          {
            "timeSent": DateTime.now(),
            'accepted': "",
            'commentBody': text.text,
            'commentId': const Uuid().v4(),
            'imageComment': [],
            'sender': user.data.name,
            'senderemail': auth.currentUser!.email,
            'time': DateTime.now().toString(),
          }
        ])
      });
    }

    if (box!.get('sendNotification') == true ||
        reportCreator == user.data.department) {
      var result = await FirebaseFirestore.instance
          .collection("Hotel List")
          .doc(user.data.hotelid)
          .get();
      List<dynamic> dataAdmin = result.data()!["admin"];
      for (var element in dataAdmin) {
        List list = element['housekeeping'];
        // print(list);
        list.forEach((element) async {
          var getToken = await FirebaseFirestore.instance
              .collection("users")
              .doc(element)
              .get();
          List listToken =
              getToken['token'] == false ? [] : await getToken['token'];
          for (var element in listToken) {
            if (element != "" && reportCreator == user.data.name) {
              // Notif().sendNotifToToken(
              //     element, title, "${user.data.name}: ${text.text}", '');
            }
            text.clear();
          }
        });
      }
    } else if (box!.get('sendNotification') ||
        reportCreator != user.data.name) {
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(creatorEmail)
          .get();
      List token = await result.data()!["token"];
      if (token.isNotEmpty) {
        token.forEach(
          (element) async {
            // Notif().sendNotifToToken(element, '$location - "$title"',
            //     "${user.data.name}: ${text.text}", '');
          },
        );
      }
      text.clear();
    }

    _isTyping = false;
    _value = '';
    // _imageList.clear();
    scrollMaxExtend(scroll);

    notifyListeners();
  }

  void receive(String id, String name) async {
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(user.data.hotel)
        .collection('lost and found')
        .doc(id)
        .update({
      // "imageProof":
      'receiveBy': name,
      'reportreceiveDate':
          DateFormat('MMM d, h:mm a').format(DateTime.now()).toString(),
      'statusReleased': 'Accepted'
    });
    _receiveByFounder = name;
    _statusItem = 'Accepted';
    notifyListeners();
  }

  int currentIndex = 0;
  List menu = ["Description", "Timeline"];
  List isiMenu = [const Text("Description"), const Text("Timeline")];
  changeIndex(int index) {
    currentIndex = index;
    print(currentIndex);
    notifyListeners();
  }
}
