// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'controller/c_user.dart';
import 'service/auth_helper.dart';

class NotificationController {
  static final user = Get.put(CUser());
  static String channelKeyNotification = "high_importance_channel";
  //***************************************************************
  //*************************REQUESTING PERMISSION*****************
  //***************************************************************

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      "resource://drawable/ic_launcher", //'resource:drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: channelKeyNotification,
          channelName: 'High Importance Notifications',
          channelDescription: 'Used for important notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: true,
        )
      ],
      debug: false,
    );
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = AuthenticationWrapper.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: const Text('Allow POST to send you notifications?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> createNewNotification(
      RemoteMessage message,
      bool isOnDuty,
      bool allowAccetedNotif,
      bool allowCloseNotif,
      bool chatNotif) async {
    if (message.data.isEmpty) return;
    try {
      final String? sender = message.data['sender'];
      final String? notifType = message.data['notifType'];
      final String? image = message.data['image'];
      final String? status = message.data['status'];

      final bool shouldShowNotification = sender != user.data.name && isOnDuty;
      if (!shouldShowNotification) {
        print(
            "❌ Notifikasi dibatalkan: sender adalah user sendiri atau off duty.");
        return;
      }

      // Cek apakah user mengaktifkan tipe notifikasi ini
      final Map<String, bool> notifPreferences = {
        "Accepted": allowAccetedNotif,
        "Close": allowCloseNotif,
        "comment": chatNotif,
        "New": true,
        "Assigned": true,
        "Claimed": true,
        "Released": true,
        "ESC": true
      };

      if (!(notifPreferences[notifType] ?? false)) {
        print("❌ Tipe notifikasi $notifType dinonaktifkan di pengaturan.");
        return;
      }

      // Buat konten notifikasi
      final NotificationContent content = NotificationContent(
        // icon: "ic_launcher",
        id: Random().nextInt(3234),
        channelKey: channelKeyNotification,
        title: message.data["title"] ?? 'Notifikasi',
        body: message.data["body"] ?? 'Pesan baru datang',
        bigPicture: image?.isNotEmpty == true ? image : null,
        largeIcon: image?.isNotEmpty == true ? image : null,
        notificationLayout: image?.isNotEmpty == true
            ? NotificationLayout.BigPicture
            : NotificationLayout.BigText,
      );

      // Tombol aksi jika status adalah "New"
      List<NotificationActionButton>? actionButtons;
      if (notifType == "New") {
        actionButtons = [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept',
            actionType: ActionType.SilentBackgroundAction,
          ),
          NotificationActionButton(
            key: 'OPEN',
            label: 'Open',
            actionType: ActionType.Default,
          ),
        ];
      }

      // Kirim notifikasi
      print(message.data["title"]);
      print(message.data["body"]);

      await AwesomeNotifications().createNotification(
        content: content,
        actionButtons: actionButtons,
      );
      if (message.data["topic"] != null) {
        print("notifikasi dari topic ${message.data["topic"]}");
      }
      if (message.data["token"] != null) {
        print("notifikasi dari token ${message.data["token"]}");
      }
      print("✅ Notifikasi $notifType berhasil dikirim.");
    } catch (e) {
      print("❌ Error saat membuat notifikasi: $e");
    }
  }

  // Future<void> onActionReceivedMethod(
  //     ReceivedAction receivedAction) async {
  //   if (receivedAction.actionType == ActionType.SilentAction ||
  //       receivedAction.actionType == ActionType.SilentBackgroundAction) {
  //     // For background actions, you must hold the execution until the end
  //     print(
  //         'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
  //     await executeLongTaskInBackground();
  //   } else {
  //     // this process is only necessary when you need to redirect the user
  //     // to a new page or use a valid context, since parallel isolates do not
  //     // have valid context, so you need redirect the execution to main isolate
  //     if (receivePort == null) {
  //       print(
  //           'onActionReceivedMethod was called inside a parallel dart isolate.');
  //       SendPort? sendPort =
  //           IsolateNameServer.lookupPortByName('notification_action_port');

  //       if (sendPort != null) {
  //         print('Redirecting the execution to main isolate process.');
  //         sendPort.send(receivedAction);
  //         return;
  //       }
  //     }

  //     return onActionReceivedImplementationMethod(receivedAction);
  //   }
  // }

  //***************************************************************
  //*************************DOWNLOAD IMAGE FROM NOTIFICATION******
  //***************************************************************

  static Future<String> downloadAndSaveImage(
      String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  //***************************************************************
  //*************************INITIALIZATIOINS**********************
  //***************************************************************

//   static Future initializeNotif(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = const AndroidInitializationSettings("icon_notif");
//     var iosInitialize = const DarwinInitializationSettings();
//     var initializationSettings = InitializationSettings(
//       android: androidInitialize,
//       iOS: iosInitialize,
//     );

//     //***************************************************************
//     //******************FOREGEOUND NOTIFICATION**********************
//     //***************************************************************
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       print("************${message.notification}******************");
//       AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         "task_notif",
//         "taskChannel",
//         importance: Importance.high,
//         priority: Priority.high,
//         styleInformation: BigTextStyleInformation(
//             message.notification!.body.toString(),
//             htmlFormatBigText: true,
//             contentTitle: message.notification!.title.toString(),
//             htmlFormatContentTitle: true),
//         playSound: true,
//       );
//       NotificationDetails platFormDetails = NotificationDetails(
//           android: androidNotificationDetails,
//           iOS: DarwinNotificationDetails(
//               badgeNumber: const DarwinNotificationDetails().badgeNumber,
//               presentBadge: true,
//               presentSound: true,
//               sound: const DarwinNotificationDetails().sound));
//       // print("${message.data} **********************************************");
//       await flutterLocalNotificationsPlugin.show(
//           GlobalFunction().generateId(),
//           message.notification?.title,
//           message.notification?.body,
//           platFormDetails,
//           payload: message.data["data"]);
//     });

//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details) async {
//         try {
//           if (details.payload != null && details.payload!.isNotEmpty) {
//             print(
//                 "${details.payload} forground notificationnnnnnnn ******************");

//             // Convert the JSON string payload to a Map
//             var data = jsonDecode(details.payload!) as Map<String, dynamic>;

//             print(
//                 "${data["id"]} ************************!@#!@#!@#!#!@#!@#!@#!@#");
//             var dataTask = await FirebaseFirestore.instance
//                 .collection(hotelCollection)
//                 .doc(user.data.hotel)
//                 .collection(data["collection"])
//                 .doc(data["id"])
//                 .get();
//             TaskModel taskModel = TaskModel.fromJson(dataTask.data()!);
//             Future.delayed(
//                 Duration.zero,
//                 () => Get.to(() => IosChatRoom(
//                       taskModel: taskModel,
//                       isTask: true,
//                       isWithKeyboard: true,
//                     )));
//           }
//         } catch (e) {
//           print(e);
//           return;
//         }
//       },
//       // onDidReceiveBackgroundNotificationResponse: (details) async {
//       //   try {
//       //     if (details.payload != null && details.payload!.isNotEmpty) {
//       //       print(
//       //           "${details.payload} forground notificationnnnnnnn ******************");

//       //       // Convert the JSON string payload to a Map
//       //       var data = jsonDecode(details.payload!) as Map<String, dynamic>;

//       //       print(
//       //           "${data["id"]} ************************!@#!@#!@#!#!@#!@#!@#!@#");
//       //       var dataTask = await FirebaseFirestore.instance
//       //           .collection(hotelCollection)
//       //           .doc(user.data.hotel)
//       //           .collection(data["collection"])
//       //           .doc(data["id"])
//       //           .get();
//       //       TaskModel taskModel = TaskModel.fromJson(dataTask.data()!);
//       //       Future.delayed(
//       //           Duration.zero,
//       //           () => Get.to(() => IosChatRoom(
//       //                 taskModel: taskModel,
//       //                 isTask: true,
//       //                 isWithKeyboard: true,
//       //               )));
//       //     }
//       //   } catch (e) {
//       //     print(e);
//       //     return;
//       //   }
//       // },
//     );
//   }

// //SCHEDULE NOTIFCATION

//   Future<void> showScheduledNotification(
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
//     TaskModel task,
//   ) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'schedule_notification',
//       'schedule_notificationChannel',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     Map<String, dynamic> payloadData = task.toJson();
//     String payloadString = jsonEncode(payloadData);

//     int iniIdNya = int.parse(task.id!).hashCode;

//     DateTime now = DateTime.now();

//     DateTime? scheduledDateTime;

//     // Parse date if available
//     if (task.setDate!.isNotEmpty) {
//       try {
//         scheduledDateTime = DateTime.parse(task.setDate!);
//       } catch (e) {
//         throw ArgumentError("Error parsing date: $e");
//       }
//     }

//     if (task.setDate!.isEmpty) {
//       try {
//         scheduledDateTime =
//             DateTime(task.time!.year, task.time!.month, task.time!.day, 0, 0);
//       } catch (e) {
//         throw ArgumentError("Error parsing date: $e");
//       }
//     }

//     // Parse time
//     if (task.setTime!.isNotEmpty) {
//       List<String> time = task.setTime!.split(":");
//       if (time.length != 2) {
//         throw ArgumentError("Invalid time format");
//       }

//       int hourString = int.tryParse(time[0]) ?? 0;
//       int minuteString = int.tryParse(time[1]) ?? 0;
//       scheduledDateTime = scheduledDateTime!.add(Duration(
//         hours: hourString,
//         minutes: minuteString,
//       ));
//     }

//     // Check if scheduledDateTime is in the past
//     if (scheduledDateTime != null && scheduledDateTime.isBefore(now)) {
//       flutterLocalNotificationsPlugin.cancel(iniIdNya).whenComplete(() =>
//           print("Notification with ID $iniIdNya is in the past. dan terhapus"));

//       return;
//     }

//     if (scheduledDateTime != null) {
//       tz.initializeTimeZones();
//       String timeZoneName = "Asia/Jakarta"; // Use Indonesia timezone
//       tz.setLocalLocation(tz.getLocation(timeZoneName));
//       final scheduledDate = tz.TZDateTime.from(scheduledDateTime, tz.local);

//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         iniIdNya,
//         'Reminder Notification',
//         '${task.location} - ${task.title} at ${task.setTime}',
//         scheduledDate,
//         platformChannelSpecifics,
//         payload: payloadString,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//       );
//       print("Notification created $scheduledDateTime with id $iniIdNya");
//     }
//   }
}
