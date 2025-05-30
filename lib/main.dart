import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_app/Screens/ios_view/ios_chatroom.dart';
import 'package:post_app/Screens/register_new_hotel/controller_register_hotel.dart';
import 'package:post_app/Screens/splashscreen.dart';
import 'package:post_app/core.dart';
import 'package:post_app/fireabase_service/firebase_auth.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/notification_controller.dart';
import 'package:post_app/variable.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'Screens/change_password/change_password_controller.dart';
import 'Screens/chatroom/chatroom_controller.dart';
import 'Screens/chatroom/widget/pop_up_menu/pop_up_menu_provider.dart';
import 'Screens/create/create_request_controller.dart';
import 'Screens/homescreen/home_controller.dart';
import 'Screens/homescreen/widget/pages/admin/admin_controller.dart';
import 'Screens/homescreen/widget/pages/lost_and_found/lost_and_found_controller.dart';
import 'Screens/lf/lf_controller.dart';
import 'Screens/settings/setting_provider.dart';
import 'Screens/sign_in/sign_in_controller.dart';
import 'controller/c_user.dart';
import 'fireabase_service/firebase_read_data.dart';
import 'global_function.dart';
import 'pop_up_notif_controller.dart';
import 'service/theme.dart';

Box? box;
final db = FirebaseReadData();
final theme = ThemeApp();
final user = Get.put(CUser());

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [appDocDir] mendapatkan letak [Hive] disimpan di memory handphone tanpa masuk ke [main.dart]
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  final box = await Hive.openBox('boxSetting');
  String userEmail = box.get("email");
  await Firebase.initializeApp();
  var data =
      await FirebaseFirestore.instance.collection("users").doc(userEmail).get();
  UserDetails userData = UserDetails.fromJson(data.data()!);
  bool isSignedIn = await FirebaseAuthService.isLoggedIn();
  try {
    if (message.data.isNotEmpty) {
      if ((message.data["notifType"] == "New" ||
              message.data["notifType"] == "Assigned") &&
          userData.popUpNotif == true) {
        final isRunning = await FlutterOverlayWindow.isActive();
        if (!isRunning) {
          PopUpNotifController.showOverlay(
            overlayTitle: message.data["title"],
            overlayContent: message.data["body"],
          );
          FlutterOverlayWindow.shareData({
            "notif_data": message.data,
            "user_name": userData.name,
            "user_email": userData.email
          });
        }
        FlutterOverlayWindow.shareData({
          "notif_data": message.data,
          "user_name": userData.name,
          "user_email": userData.email
        });
      } else if (isSignedIn) {
        NotificationController.createNewNotification(
            message,
            userData.isOnDuty!,
            userData.receiveNotifWhenAccepted!,
            userData.receiveNotifWhenClose!,
            userData.sendChatNotif!);
      } else {
        print("User tidak sedang login jadi notifikasi tidak di tampilkan");
      }
    }
  } catch (e) {
    // print(e);
    return;
  }
}

@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  await Firebase.initializeApp();
  TaskModel? task;
  // Inisialisasi ReceivePort
  ReceivePort? receivePort;
  receivePort = ReceivePort('Notification action port in main isolate')
    ..listen((silentData) => print("Tombol terima diterima"));

  // Mendaftarkan port dengan nama
  IsolateNameServer.registerPortWithName(
      receivePort.sendPort, 'notification_action_port');

  // Listener untuk pesan saat aplikasi dibuka dari notifikasi
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (message.data.isNotEmpty) {
      Map<String, dynamic> mapdata = jsonDecode(message.data["data"]);

      var data = await FirebaseFirestore.instance
          .collection(hotelCollection)
          .doc(user.data.hotel)
          .collection(collectionTasks)
          .doc(mapdata["id"])
          .get();

      if (data.exists) {
        task = TaskModel.fromJson(data.data()!);
      }

      if (task != null) {
        Get.to(() =>
            IosChatRoom(taskModel: task!, isTask: true, isWithKeyboard: true));
      } else {
        print("Task not found");
      }
    }
  });

  // Pemrosesan aksi yang diterima
  if (receivedAction.actionType == ActionType.SilentBackgroundAction) {
    // Jika tombol "terima" ditekan
    if (receivedAction.buttonKeyInput == "Accept") {
      // Perbarui status di Firebase
      await FirebaseFirestore.instance
          .collection(hotelCollection)
          .doc(user.data.hotel)
          .collection(collectionTasks)
          .doc(receivedAction.payload!["id"])
          .update({"status": "Accepted", "receiver": user.data.name});
      var result = await FirebaseFirestore.instance
          .collection('users')
          .doc(task!.emailSender)
          .get();
      String token = result.data()!["token"];
      bool receiveNotifWhenAccepted =
          result.data()!['ReceiveNotifWhenAccepted'];
      print("$receiveNotifWhenAccepted ====================================");
      Notif().sendNotifToToken(
          token,
          task!.sendTo!,
          "${user.data.name} has accept this request: ${task!.location} - ${task!.title}",
          "",
          task!.id!,
          task!.typeReport!,
          task!.status!,
          "");
      print("Status diperbarui di Firebase");
    }
    await null; // Menahan eksekusi hingga selesai
  } else {
    // Jika tombol "open" ditekan
    if (receivedAction.buttonKeyInput == "Open") {
      // Dapatkan data task dari Firebase
      var data = await FirebaseFirestore.instance
          .collection(hotelCollection)
          .doc(user.data.hotel)
          .collection(collectionTasks)
          .doc(receivedAction.payload!["id"])
          .get();

      TaskModel? task;
      if (data.exists) {
        task = TaskModel.fromJson(data.data()!);
      }

      if (task != null) {
        // Arahkan ke halaman IosChatRoom
        Get.to(() =>
            IosChatRoom(taskModel: task!, isTask: true, isWithKeyboard: true));
      } else {
        print("Task not found");
      }
    }
  }
}

// overlay entry point
@pragma("vm:entry-point")
void overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
          child: InkWell(
        onTap: () => PopUpNotifController.closeOverlay(),
        child: const CupertinoOverlayScreen(),
      ))));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);

  // FlutterOverlayWindow.registerOverlayEntryPoint(overlayMain);
  Intl.systemLocale = await findSystemLocale();
  await Hive.initFlutter();
  Hive.registerAdapter(SettingModelAdapter());
  box = await Hive.openBox('boxSetting');
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  await FirebaseMessaging.instance.getInitialMessage();
  AwesomeNotifications()
      .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  NotificationController.initializeNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SessionsUser.getUser();
  // Workmanager().initialize(callbackDispatcher);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => CreateRequestController()),
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => ChatRoomController()),
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => ReportLFController()),
        ChangeNotifierProvider(create: (context) => PopUpMenuProvider()),
        ChangeNotifierProvider(create: (context) => GlobalFunction()),
        ChangeNotifierProvider(create: (context) => AdminController()),
        ChangeNotifierProvider(create: (context) => ControllerRegisterHotel()),
        ChangeNotifierProvider(
            create: (context) => LostAndFoundControntroller()),
        ChangeNotifierProvider(create: (context) => ChangePasswordController()),
        StreamProvider<List<TaskModel>>(
          create: (context) => db.streamTask(),
          initialData: const [],
          catchError: (context, error) => [],
        ),
        StreamProvider<List<Departement>>(
          create: (context) => db.getDepartementData(),
          initialData: const [],
          catchError: (context, error) => [],
        ),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 700),
          builder: (context, child) => GetMaterialApp(
            theme: theme.themeLight,
            darkTheme: theme.themeDark,
            themeMode: ThemeMode.system,
            // locale: Locale('zh'),
            localeResolutionCallback: (
              locale,
              supportedLocales,
            ) {
              if (supportedLocales.contains(Locale(locale!.languageCode))) {
                return locale;
              } else {
                return const Locale('en', '');
              }
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            // initialRoute: AppRouter.splashRoute,
          ),
        );
      }));
}
