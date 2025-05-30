import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/fireabase_service/firebase_update_data.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../controller/c_user.dart';
import '../../../sign_up/signup.dart';

class PopUpMenuProvider with ChangeNotifier {
  final db = FirebaseUpdateData();
  final cUser = Get.put(CUser());
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  //ini methode untuk mengganti title
  String _title = "";
  String get title => _title;
  void changeTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  bool _isTitleChange = false;
  bool get isTitleChange => _isTitleChange;
  isChangeTitle(bool newValue) {
    _isTitleChange = newValue;
    notifyListeners();
  }

  void storeNewTitle(BuildContext context, String tasksId, int index,
      String emailSender) async {
    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({"title": ""});

    changeTitle("");
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty) {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(element, _title, "${cUser.data.name}", '');
          },
        );
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    notifyListeners();
  }

  //method for change teh location
  String _location = "";
  String get location => _location;
  void changelocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }

  void storeNewLocation(BuildContext context, String tasksId,
      String oldLocation, String emailSender, String newLocation) async {
    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': "",
          'commentBody': "",
          'commentId': const Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation':
              '${cUser.data.name} has changed location from "$oldLocation" to "$newLocation"',
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ]),
      "location": newLocation
    });
    changelocation(newLocation);
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty) {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(
            //     element,
            //     oldLocation,
            //     "${cUser.data.name} has change the location to $newLocation",
            //     '');
          },
        );
      }
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    notifyListeners();
  }

  // methon untuk mengubah jadwal date....
  void storeNewDate(BuildContext context, String tasksId, String oldDate,
      String emailSender, String location) async {
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);

    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': "",
          'commentBody': "",
          'commentId': const Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate':
              '${cUser.data.name} has changed the date from "$oldDate" to "${provider.datePicked}"',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ]),
      "setDate": provider.datePicked,
    });
    // Navigator.pop(context);
    // notifyListeners();
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty) {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(
            //     element,
            //     '$location "$_title"',
            //     "${cUser.data.name} has set due date  ${provider.datePicked}",
            //     '');
          },
        );
      }
    }
    // Navigator.pop(context);
    notifyListeners();
  }

  // methon untuk mengubah jadwal time....
  void storeNewTime(BuildContext context, String tasksId, String oldTime,
      String emailSender, String location) async {
    final provider =
        Provider.of<CreateRequestController>(context, listen: false);

    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': "",
          'commentBody': "",
          'commentId': const Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime':
              '${cUser.data.name} has changed the date from "$oldTime" to "${provider.selectedTime}"',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "",
        }
      ]),
      "setTime": provider.selectedTime,
    });

    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty && provider.newDate == '') {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(
            //     element,
            //     '$location "$_title"',
            //     "${cUser.data.name} has set the time ${provider.selectedTime}",
            //     '');
          },
        );
      }
    }

    // Navigator.pop(context);
    notifyListeners();
  }

  //methode ini untuk menghapus schedule
  void deleteSchedule(BuildContext context, String tasksId, String emailSender,
      String location) async {
    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': "",
          'commentBody': "",
          'commentId': const Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "",
          'scheduleDelete': "${cUser.data.name}",
        }
      ]),
      "setDate": '',
      "setTime": '',
    });

    // notifyListeners();
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty) {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(element, '$location "$_title"',
            //     "${cUser.data.name} has deleted the schedule", '');
          },
        );
      }
    }
  }

  //method untuk mengubah status menjadi hold
  void holdFunction(BuildContext context, String tasksId, String emailSender,
      String location) async {
    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': "",
          'commentBody': "",
          'commentId': const Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "${cUser.data.name}",
          'resume': "",
          'scheduleDelete': "",
        }
      ]),
      "status": 'Hold',
      "receiver": cUser.data.name
    });
    // ignore: use_build_context_synchronously
    Provider.of<ChatRoomController>(context, listen: false)
        .changeStatus("Hold", "${cUser.data.name}", '');
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty) {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(element, '$location "$_title"',
            //     "${cUser.data.name} has hold this request", '');
          },
        );
      }
    }
    notifyListeners();
  }

  //function untuk resume status
  void resumeFunction(BuildContext context, String tasksId, String emailSender,
      String location) async {
    await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .doc(tasksId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now(),
          'accepted': "",
          'assignTask': "",
          'assignTo': "",
          'commentBody': "",
          'commentId': const Uuid().v4(),
          'description': "",
          'esc': '',
          'imageComment': [],
          'sender': cUser.data.name,
          'senderemail': auth.currentUser!.email,
          'setDate': '',
          'setTime': '',
          'time': DateTime.now(),
          'titleChange': "",
          'newlocation': "",
          'hold': "",
          'resume': "${cUser.data.name}",
          'scheduleDelete': "",
        }
      ]),
      "status": 'Resume',
      "receiver": cUser.data.name
    });
    // ignore: use_build_context_synchronously
    Provider.of<ChatRoomController>(context, listen: false)
        .changeStatus("Resume", "${cUser.data.name}", '');
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(emailSender)
        .get();
    var token = result.data()!["token"];
    if (token != false) {
      List hasToken = token;
      if (hasToken.isNotEmpty) {
        token.forEach(
          (element) {
            // Notif().sendNotifToToken(element, '$location "$_title"',
            //     "${cUser.data.name} has resume this request", '');
          },
        );
      }
    }
    notifyListeners();
  }
}
