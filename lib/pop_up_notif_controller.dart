import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/fireabase_service/fcm_service.dart';

class PopUpNotifController {
  /// Check if overlay permission is granted
  static Future<bool> checkPermission() async {
    final bool status = await FlutterOverlayWindow.isPermissionGranted();
    return status;
  }

  /// Request overlay permission
  static Future<bool?> requestPermission() async {
    final bool? status = await FlutterOverlayWindow.requestPermission();
    return status;
  }

  static void permissionPopUpDialog(context) {
    final theme = Theme.of(context);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Allow Display Over Other Apps?"),
            content: Text(
              "This app requires permission to display content over other apps. Please enable this permission to allow floating features and ensure full functionality.",
              style: TextStyle(
                  color: theme.focusColor,
                  fontSize: fullWidth < maxWidth ? 14.sp : 14),
            ),
            actions: [
              CupertinoButton(
                child: Text(
                  "No",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: fullWidth < maxWidth ? 14.sp : 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoButton(
                  child: Text(
                    "Setting",
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: fullWidth < maxWidth ? 14.sp : 14),
                  ),
                  onPressed: () async {
                    requestPermission();
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  /// Show overlay window
  static Future<void> showOverlay({
    int height = WindowSize.fullCover,
    int width = WindowSize.matchParent,
    OverlayAlignment alignment = OverlayAlignment.center,
    NotificationVisibility visibility = NotificationVisibility.visibilityPublic,
    OverlayFlag flag = OverlayFlag.defaultFlag,
    String overlayTitle = 'Window is Activated',
    String overlayContent = 'New Notification Received',
    bool enableDrag = false,
    PositionGravity gravity = PositionGravity.none,
    Offset? startPosition,
  }) async {
    await FlutterOverlayWindow.showOverlay(
      height: 450,
      width: 600,
      alignment: alignment,
      visibility: visibility,
      flag: OverlayFlag.defaultFlag,
      overlayTitle: overlayTitle,
      overlayContent: overlayContent,
      enableDrag: enableDrag,
      positionGravity: gravity,
    );
  }

  /// Close overlay window
  static Future<void> closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
  }

  /// Send data to overlay
  static Future<void> shareData(Map<String, dynamic> message) async {
    final messageJson = jsonEncode(message); // hanya kirim bagian data
    await FlutterOverlayWindow.shareData(messageJson);
  }

  /// Listen for data from overlay
  static void startListening() {
    FlutterOverlayWindow.overlayListener.listen((event) {
      log("Overlay Event: $event");
    });
  }

  /// Change overlay flag (e.g., focus for text input)
  static Future<void> updateFlag(OverlayFlag flag) async {
    await FlutterOverlayWindow.updateFlag(flag);
  }

  /// Resize overlay while running
  static Future<void> resizeOverlay(int width, int height) async {
    await FlutterOverlayWindow.resizeOverlay(width, height, false);
  }

  /// Get current overlay position
  static Future<OverlayPosition?> getOverlayPosition() async {
    return await FlutterOverlayWindow.getOverlayPosition();
  }
}

class CupertinoOverlayScreen extends StatefulWidget {
  const CupertinoOverlayScreen({super.key});

  @override
  State<CupertinoOverlayScreen> createState() => _CupertinoOverlayScreenState();
}

class _CupertinoOverlayScreenState extends State<CupertinoOverlayScreen> {
  final List<Map<String, String>> _queue = [];

  // @override
  // void initState() {
  //   FlutterOverlayWindow.overlayListener.listen((data) {
  //     if (data is Map) {
  //       final notifData = Map<String, String>.from(data["notif_data"] ?? {});
  //       final userName = data["user_name"]?.toString() ?? "";
  //       final userEmail = data["user_email"]?.toString() ?? "";

  //       if (notifData.isNotEmpty) {
  //         final newNotif = {
  //           "title": notifData['title'].toString(),
  //           "body": notifData['body'].toString(),
  //           "id": notifData['id'].toString(),
  //           "collection": notifData['collection'].toString(),
  //           "location": notifData['location'].toString(),
  //           "sendTo": notifData['sendTo'].toString(),
  //           "hotel": notifData['hotel'].toString(),
  //           "user_name": userName.toString(),
  //           "user_email": userEmail.toString()
  //         };

  //         // Pastikan setState dijalankan setelah frame pertama selesai dirender
  //         WidgetsBinding.instance.addPostFrameCallback((_) {
  //           if (mounted) {
  //             setState(() {
  //               _queue.add(newNotif);
  //             });
  //           }
  //         });
  //       }
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    FlutterOverlayWindow.overlayListener.listen((data) {
      if (data is Map) {
        final notifData = Map<String, String>.from(data["notif_data"] ?? {});
        final userName = data["user_name"]?.toString() ?? "";
        final userEmail = data["user_email"]?.toString() ?? "";

        if (notifData.isNotEmpty) {
          final newNotif = {
            "title": notifData['title'].toString(),
            "body": notifData['body'].toString(),
            "id": notifData['id'].toString(),
            "collection": notifData['collection'].toString(),
            "location": notifData['location'].toString(),
            "sendTo": notifData['sendTo'].toString(),
            "hotel": notifData['hotel'].toString(),
            "user_name": userName,
            "user_email": userEmail,
          };

          // Cek apakah kombinasi id + title + body sudah ada di _queue
          final isDuplicate = _queue.any((item) =>
              item["id"] == newNotif["id"] &&
              item["title"] == newNotif["title"] &&
              item["body"] == newNotif["body"]);

          if (!isDuplicate) {
            if (mounted) {
              setState(() {
                _queue.add(newNotif);
              });
            }
          }
        }
      }
    });

    super.didChangeDependencies();
  }

  void _nextNotification() {
    if (_queue.length <= 1) {
      FlutterOverlayWindow.closeOverlay();
      return;
    }

    setState(() {
      _queue.removeAt(0); // Remove current
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_queue);
    if (_queue.isEmpty || _queue.first["title"] == null) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Lottie.asset("images/post-animated-logo.json",
                  height: 100, width: 100, fit: BoxFit.fill, repeat: false),
              const Text(
                "New request notification!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    final current = _queue.first;
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _buildDialog(context, current),
      ),
    );
  }

  bool _isLoading = false;
  Widget _buildDialog(BuildContext context, Map<String, String> notif) {
    // final controller = Provider.of<ChatRoomController>(context, listen: false);
    return Container(
      key: ValueKey(notif["title"]! + notif["body"]!),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // borderRadius: BorderRadius.circular(3),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black26,
        //     blurRadius: 12,
        //     offset: Offset(0, 4),
        //   )
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset("images/post-animated-logo.json",
              height: 100, width: 100, fit: BoxFit.fill, repeat: false),
          if (_queue.length > 1)
            Text(
              "(${_queue.length.toString()})",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          Text(
            notif["title"]!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            notif["body"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text("Close"),
                onPressed: () {
                  FlutterOverlayWindow.closeOverlay();
                  _queue.removeAt(0);
                },
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                onPressed: () async {
                  _isLoading = true;
                  try {
                    await FirebaseFirestore.instance
                        .collection('Hotel List')
                        .doc(notif["hotel"]!)
                        .collection(notif["collection"]!)
                        .doc(notif["id"])
                        .update({
                      "status": "Accepted",
                      'isFading': true,
                      "receiver": "${notif["user_name"]}",
                      "emailReceiver": notif["user_email"],
                    });
                    await Notif().sendNotifToTopic(
                        notif["id"]!,
                        notif["sendTo"]!,
                        "${notif["user_name"]} has accept this request: ${notif["location"]} - ${notif["title"]}",
                        notif["id"]!,
                        "tasks",
                        "",
                        "Accepted",
                        "Accepted",
                        notif["location"]!,
                        notif["sendTo"]!,
                        notif["hotel"]!);
                    _nextNotification();
                  } catch (e) {
                    debugPrint(e.toString());
                  } finally {
                    _isLoading = false;
                  }
                  setState(() {});
                },
                child: Builder(builder: (context) {
                  if (_isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return const Text("Accept");
                }),
              ),
              if (_queue.length > 1)
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  onPressed: _nextNotification,
                  child: const Text("Next"),
                )
            ],
          )
        ],
      ),
    );
  }
}
