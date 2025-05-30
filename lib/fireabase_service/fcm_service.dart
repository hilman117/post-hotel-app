// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/controller/c_user.dart';

class Notif {
  var serverkey2 =
      "AAAAcZoC9wI:APA91bFjuqIj--eZrTJGEJozCvlhSTSvCt1Aohba_EKqsu0msJcGrRL4A1Ou8PoF6GdK1_fX9o6CHUVz1LA6Re43AQsT-lkG2lKCdnvQ6EOQVC-bdIuM97GHME8yG-714OvP_q5b3aSi";
  var serverkey =
      "AAAAcZoC9wI:APA91bFjuqIj--eZrTJGEJozCvlhSTSvCt1Aohba_EKqsu0msJcGrRL4A1Ou8PoF6GdK1_fX9o6CHUVz1LA6Re43AQsT-lkG2lKCdnvQ6EOQVC-bdIuM97GHME8yG-714OvP_q5b3aSi";

  final fcm = FirebaseMessaging.instance;
  final user = Get.put(CUser());

//***************************************************************
//*************************GET TOKEN FROM FIRESBASEAUTH**********
//***************************************************************

  Future<String?> getToken() async {
    String? token = await fcm.getToken();
    if (token != null) {
      print("FCM Token: $token");
    }

    return token;
  }

  //***************************************************************
  //*************************MEHTODE TO SAVE TOPIC*****************
  //***************************************************************

  Future<void> saveTopic(String topic) async {
    await fcm
        .subscribeToTopic(topic)
        .then((value) => print("subscription to topic $topic"));
  }

  Future<void> unsubcribeTopic(String topic) async {
    await fcm.unsubscribeFromTopic(topic);
  }

//***************************************************************
//*********METHODE TO SEND NOTIFICATION TO TOPIC*****************
//***************************************************************

  Future<void> sendNotifToTopic(
      String topic,
      String title,
      String body,
      String id,
      String collection,
      String image,
      String status,
      String notifType,
      String location,
      String sendTo,
      String hotel) async {
    // String hotelIdTopic = user.data.hotelid! + topic;
    var payload = {
      // "notification": {"title": title, "body": body},
      // "title": title,
      // "body": body,
      'topic': topic,
      "data": {
        "id": id.toString(),
        "collection": collection.toString(),
        "image": image.isEmpty ? "" : image.toString(),
        "status": status.toString(),
        "title": title.toString(),
        "body": body.toString(),
        "sender": user.data.name,
        "notifType": notifType.toString(),
        'topic': topic.toString(),
        //tambahkan 3 field baru dibawah ini di kode web? [BELUM], hapus jika sudah selesai di tambahkan.
        "location": location.toString(),
        "sendTo": sendTo.toString(),
        "hotel": hotel.toString()
      },
      "content_available": true
    };
    // print("----------------------------");
    // print(data);
    var respon = await http.post(
        Uri.parse(
            "https://us-central1-post-app-d6f0c.cloudfunctions.net/sendNotifToTopic"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload));
    if (respon.statusCode == 200) {
      print("Notifikasi berhasil dikirim: ${respon.body}");
    } else {
      print("Gagal mengirim notifikasi: ${respon.statusCode} - ${respon.body}");
    }
  }

//***************************************************************
//*******METHODE TO SEND NOTIF TO SPESIFIC TOKEN/DEVICE**********
//***************************************************************
  Future<void> sendNotifToToken(
      String token,
      String title,
      String body,
      String image,
      String id,
      String collection,
      String status,
      String notifType) async {
    var payload = {
      // "notification": {"title": title, "body": body, "image": image},
      // "title": title,
      // "body": body,
      'token': token,
      "data": {
        "id": id,
        "collection": collection,
        "sender": user.data.name,
        "image": image.isEmpty ? "" : image,
        "status": status,
        "title": title,
        "body": body,
        "notifType": notifType,
        'token': token,
      },
      "content_available": true
    };
    // print("----------------------------");
    // print(data);
    var respon = await http.post(
        Uri.parse(
            "https://us-central1-post-app-d6f0c.cloudfunctions.net/sendNotifToTopic"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload));
    if (respon.statusCode == 200) {
      print("Notifikasi berhasil dikirim: ${respon.body}");
    } else {
      print("Gagal mengirim notifikasi: ${respon.statusCode} - ${respon.body}");
    }
  }
}
