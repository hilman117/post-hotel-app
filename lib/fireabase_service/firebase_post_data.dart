import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/variable.dart';
import 'package:uuid/uuid.dart';

class FirebasePostData {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final commentId = const Uuid().v1();
  final user = Get.put(CUser());

  //creare task
  Future createTask({
    required BuildContext context,
    required String hotelName,
    required List<String> image,
    required List<String> assigned,
    required List<String> registeredTask,
    required String description,
    required String emailReceiver,
    required String emailSender,
    required String from,
    required String id,
    required String location,
    required String positionSender,
    required String profileImageSender,
    required String receiver,
    required String sendTo,
    required String sender,
    required String setDate,
    required String setTime,
    required Timestamp time,
    required String closeTime,
    required String colorUser,
    required String title,
    required String status,
    required String iconDepartement,
    required String topic,
    required String resolusi,
  }) async {
    try {
      await firestore
          .collection(hotelCollection)
          .doc(hotelName)
          .collection(collectionTasks)
          .doc(id)
          .set({
        "subscriberToken": FieldValue.arrayUnion([topic]),
        "registeredTask": FieldValue.arrayUnion(registeredTask),
        "assigned": FieldValue.arrayUnion(assigned),
        "image": image,
        "description": description,
        "emailReceiver": emailReceiver,
        "emailSender": emailSender,
        "from": from,
        "id": id,
        "typeReport": "tasks",
        "location": location,
        "positionSender": positionSender,
        "profileImageSender": profileImageSender,
        "receiver": receiver,
        "sendTo": sendTo,
        "sender": sender,
        "setDate": setDate,
        "setTime": setTime,
        "status": status,
        "title": title,
        "isFading": true,
        "time": time,
        "closeTime": closeTime,
        "iconDepartement": iconDepartement,
        "resolusi": resolusi,
        "isValueable": false,
        "comment": FieldValue.arrayUnion([
          {
            "accepted": "",
            "assignTask": "",
            "assignTo": "",
            "colorUser": colorUser,
            "commentBody": "$title for $location",
            "esc": "",
            "hold": "",
            "newlocation": "",
            "resume": "",
            "scheduleDelete": "",
            "sender": sender,
            "senderemail": emailSender,
            "setDate": "",
            "setTime": "",
            "titleChange": "",
            "time": DateTime.now().toUtc().toIso8601String(),
            "timeSent": DateTime.now().toUtc().toIso8601String(),
            "imageComment": image,
            "description": description,
            "commentId": commentId,
          }
        ])
      });

      Future.delayed(
        const Duration(seconds: 2),
        () async {
          await firestore
              .collection("Hotel List")
              .doc(hotelName)
              .collection("tasks")
              .doc(id)
              .update({"isFading": false});
        },
      );
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //creare task
  Future createLfReport({
    required BuildContext context,
    required String hotelName,
    required String assigned,
    required List<String> image,
    required String description,
    required String emailReceiver,
    required String emailSender,
    required String from,
    required String id,
    required String location,
    required String positionSender,
    required String profileImageSender,
    required String receiver,
    required String sendTo,
    required String sender,
    required String setDate,
    required String setTime,
    required Timestamp time,
    required String closeTime,
    required String colorUser,
    required String title,
    required String status,
    required String iconDepartement,
    required String senderToken,
    required bool isValueable,
  }) async {
    try {
      await firestore
          .collection("Hotel List")
          .doc(hotelName)
          .collection("lost and found")
          .doc(id)
          .set({
        "subscriberToken": FieldValue.arrayUnion([senderToken]),
        "assigned": FieldValue.arrayUnion([assigned]),
        "image": image,
        "description": description,
        "emailReceiver": emailReceiver,
        "emailSender": emailSender,
        "from": from,
        "id": id,
        "location": location,
        "positionSender": positionSender,
        "profileImageSender": profileImageSender,
        "receiver": receiver,
        "sendTo": sendTo,
        "typeReport": "lost and found",
        "sender": sender,
        "setDate": setDate,
        "setTime": setTime,
        "status": status,
        "title": title,
        "isFading": true,
        "time": time,
        "closeTime": closeTime,
        "iconDepartement": iconDepartement,
        "isValueable": isValueable,
        "comment": FieldValue.arrayUnion([
          {
            "accepted": "",
            "assignTask": "",
            "assignTo": "",
            "colorUser": colorUser,
            "commentBody": "",
            "esc": "",
            "hold": "",
            "newlocation": "",
            "resume": "",
            "scheduleDelete": "",
            "sender": sender,
            "senderemail": emailSender,
            "setDate": "",
            "setTime": "",
            "titleChange": "",
            "time": DateTime.now().toUtc().toIso8601String(),
            "timeSent": DateTime.now().toUtc().toIso8601String(),
            "imageComment": image,
            "description": description != ""
                ? "found: $title at $location \n$description"
                : "found: $title at $location",
            "commentId": commentId,
          }
        ])
      });
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          await firestore
              .collection("Hotel List")
              .doc(hotelName)
              .collection("lost and found")
              .doc(id)
              .update({"isFading": false});
        },
      );
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //create new account
  Future createAccount({
    required String email,
    required String password,
    required String name,
    required String departement,
    required String role,
    required String hotel,
    required String colorsUser,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    await firestore.collection("users").doc(email.toLowerCase()).set({
      "name": name,
      "position": "",
      "hotelid": hotel,
      "department": departement,
      "hotel": hotel,
      "location": "",
      "email": email.toLowerCase(),
      "uid": auth.currentUser!.email,
      "acceptRequest": 0,
      "closeRequest": 0,
      "createRequest": 0,
      'ReceiveNotifWhenAccepted': true,
      'ReceiveNotifWhenClose': true,
      'isOnDuty': true,
      'sendChatNotif': true,
      'token': [],
      "profileImage": "",
      "userColor": colorsUser,
      "accountType": role,
      "createdAt": DateTime.now()
    });
  }

  Future createDepartement(String hotelName, String nameDepartement,
      String color, String deptIcon) async {
    await firestore
        .collection(hotelCollection)
        .doc(hotelName)
        .collection(collectionDepartement)
        .doc(nameDepartement)
        .set({
      "departement": nameDepartement,
      "color": color,
      "isActive": false,
      "totalRequest": 0,
      "departementIcon": deptIcon,
      "title": [],
    });
  }
}
