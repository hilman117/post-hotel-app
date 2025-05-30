// ignore_for_file: prefer_final_fields, avoid_print, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_app/Screens/chatroom/widget/action_area/widget/keyboard/keyboard.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/common_widget/show_dialog.dart';
import 'package:post_app/core.dart';
import 'package:post_app/fireabase_service/firebase_post_data.dart';
import 'package:post_app/fireabase_service/firebase_update_data.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/variable.dart';
import 'package:uuid/uuid.dart';

import '../../controller/c_user.dart';

class ChatRoomController with ChangeNotifier {
  final cUser = Get.put(CUser());
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseUpdateData();
  ScrollController scrollController = ScrollController();
  // File? _image;
  // File? get images => _image;
  // String imageUrl = "";
  TextEditingController descriptionController = TextEditingController();
  String imageName = '';
  final ImagePicker _picker = ImagePicker();
  XFile? _fromCamera;
  XFile? get fromCamera => _fromCamera;
  List<XFile?> _imageList = [];
  List<XFile?> get imagesList => _imageList;
  List<String> _imageUrl = [];
  List<String> get imageUrls => _imageUrl;
  bool isLoadImageComment = false;
  Future<void> selectImage(BuildContext context, ImageSource source) async {
    isLoadImageComment = true;
    notifyListeners();
    try {
      List<XFile?> selectedImage =
          await _picker.pickMultiImage(imageQuality: 30);
      if (selectedImage.isNotEmpty) {
        _imageList.addAll(selectedImage);
        // Navigator.pop(context);
      }
    } finally {
      isLoadImageComment = false;
      notifyListeners();
    }
  }

  Future<void> selectFromCamera(BuildContext context) async {
    _fromCamera =
        await _picker.pickImage(imageQuality: 30, source: ImageSource.camera);
    if (_fromCamera != null) {
      _imageList.add(_fromCamera);
      print(_imageList.length);
      Navigator.pop(context);
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
      final position = scrollController.position.maxScrollExtent;
      scroll.animateTo(position,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void clearImage() {
    _imageList.clear();
    notifyListeners();
  }

  String _status = "";
  String get status => _status;
  String _receiver = "";
  String get receiver => _receiver;
  String _assignTo = "";
  String get assignTo => _assignTo;
  changeStatus(
      String newStatus, String newReceiver, String newAssignmentTarget) {
    _status = newStatus;
    _receiver = newReceiver;
    _assignTo = newAssignmentTarget;
    notifyListeners();
  }

  //untuk menyesuaikan warna bubble
  Color getBubbleColor(ThemeData theme, int clientColor, bool isMe) {
    if (isMe == true && ThemeMode.system == ThemeMode.dark) {
      return theme.cardColor;
    } else if (isMe == true && ThemeMode.system == ThemeMode.light) {
      return Colors.grey.withOpacity(0.1);
    }
    return Color(clientColor).withOpacity(0.1);
  }

  //function untuk mengirim kan komen.....
  String textComment = '';
  void typing(String value) {
    textComment = value;
    notifyListeners();
  }

  FirebasePostData notif = FirebasePostData();
  bool _isImageLoad = false;
  bool get isImageLoad => _isImageLoad;
  // final TextEditingController commentBody = TextEditingController();
  Future<void> sendComment(
      BuildContext context,
      ScrollController scroll,
      TextEditingController textController,
      bool needToSendNotif,
      TaskModel task,
      String collection,
      List<Departement> listDept) async {
    try {
      _imageUrl.clear();
      List<String> listTopic = task.subscriberToken!;
      if (_imageList.isNotEmpty) {
        loading(context);
        for (var element in _imageList) {
          String imageExtension = imageName.split('.').last;
          _isImageLoad = true;
          notifyListeners();
          final ref = FirebaseStorage.instance.ref(
              "${cUser.data.hotelid}/${cUser.data.uid} + ${DateTime.now().toString()}.$imageExtension");
          await ref.putFile(File(element!.path));
          String downloadUrl = await ref.getDownloadURL();
          _imageUrl.add(downloadUrl);
          notifyListeners();
        }

        if (_imageUrl.length == _imageList.length) {
          _imageList.clear();
          await sendNotifications(
              imageUrls.first, listTopic, task, textController);
          await db.updateChat(
            taskmodel: task,
            collection: collection,
            taskId: task.id,
            commentText: textController.text,
            commentId: const Uuid().v4(),
            imageComment: _imageUrl,
          );
          Navigator.pop(context);
        }
      } else {
        await sendNotifications("", listTopic, task, textController);
        await db.updateChat(
          taskmodel: task,
          collection: collection,
          taskId: task.id,
          commentText: textController.text,
          commentId: const Uuid().v4(),
        );
      }

      if (!task.assigned!.contains(cUser.data.name) &&
          task.sender != cUser.data.name) {
        Notif().saveTopic(task.id!.toLowerCase());
      }
      scrollMaxExtend(scroll);
      Future.delayed(
        const Duration(seconds: 4),
        () async {
          FirebaseFirestore.instance
              .collection('Hotel List')
              .doc(cUser.data.hotel)
              .collection(collection)
              .doc(task.id)
              .update({
            'isFading': false,
          });
        },
      );

      notifyListeners();
    } catch (e) {
      ShowDialog().errorDialog(context, e.toString());
    } finally {
      // Ensure variables are reset to default values
      textController.clear();
      _isImageLoad = false;
      notifyListeners();
    }
  }

  Future<void> sendNotifications(String imageUrl, List<String> listTopic,
      TaskModel task, TextEditingController textController) async {
    if (textController.text.isNotEmpty && imageUrl.isNotEmpty) {
      //SEND  NOTIF TO MOBILE RECEIVER
      for (var topic in listTopic) {
        Notif().sendNotifToTopic(
            topic.toLowerCase(),
            task.sendTo!,
            '"${task.location} - ${task.title}"\n${cUser.data.name} : ${textController.text}',
            task.id!,
            task.typeReport!,
            imageUrl,
            task.status!,
            "comment",
            task.location!,
            task.sendTo!,
            cUser.data.hotel!);
      }
      //SEND  NOTIF TO WEB RECEIVER
      Notif().sendNotifToTopic(
          "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${task.sendTo!.removeAllWhitespace.toLowerCase()}",
          task.sendTo!,
          '"${task.location} - ${task.title}"\n${cUser.data.name} : ${textController.text}',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
      //SEND  NOTIF TO ID TASK
      Notif().sendNotifToTopic(
          task.id!.toLowerCase(),
          task.sendTo!,
          '"${task.location} - ${task.title}"\n${cUser.data.name} : ${textController.text}',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
    } else if (textController.text.isNotEmpty && imageUrl.isEmpty) {
      //SEND  NOTIF TO MOBILE RECEIVER
      for (var topic in listTopic) {
        Notif().sendNotifToTopic(
            topic.toLowerCase(),
            task.sendTo!,
            '"${task.location} - ${task.title}"\n${cUser.data.name} : ${textController.text}',
            task.id!,
            task.typeReport!,
            imageUrl,
            task.status!,
            "comment",
            task.location!,
            task.sendTo!,
            cUser.data.hotel!);
      }
      //SEND  NOTIF TO WEB RECEIVER
      Notif().sendNotifToTopic(
          "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${task.sendTo!.removeAllWhitespace.toLowerCase()}",
          task.sendTo!,
          '"${task.location} - ${task.title}"\n${cUser.data.name} : ${textController.text}',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
      //SEND  NOTIF TO ID TASK
      Notif().sendNotifToTopic(
          task.id!.toLowerCase(),
          task.sendTo!,
          '"${task.location} - ${task.title}"\n${cUser.data.name} : ${textController.text}',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
    } else if (textController.text.isEmpty && imageUrl.isNotEmpty) {
      //SEND  NOTIF TO MOBILE RECEIVER
      for (var topic in listTopic) {
        Notif().sendNotifToTopic(
            topic.toLowerCase(),
            task.sendTo!,
            '"${task.location} - ${task.title}"\n${cUser.data.name}',
            task.id!,
            task.typeReport!,
            imageUrl,
            task.status!,
            "comment",
            task.location!,
            task.sendTo!,
            cUser.data.hotel!);
      }
      //SEND  NOTIF TO WEB RECEIVER
      Notif().sendNotifToTopic(
          "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${task.sendTo!.removeAllWhitespace.toLowerCase()}",
          task.sendTo!,
          '"${task.location} - ${task.title}"\n${cUser.data.name}',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
      //SEND  NOTIF TO ID TASK
      Notif().sendNotifToTopic(
          task.id!.toLowerCase(),
          task.sendTo!,
          '"${task.location} - ${task.title}"\n${cUser.data.name}',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
    } else {
      //SEND  NOTIF TO MOBILE RECEIVER
      for (var topic in listTopic) {
        Notif().sendNotifToTopic(
            topic.toLowerCase(),
            task.sendTo!,
            '${cUser.data.name} : "${task.location} - ${task.title}"',
            task.id!,
            task.typeReport!,
            imageUrl,
            task.status!,
            "comment",
            task.location!,
            task.sendTo!,
            cUser.data.hotel!);
      }
      //SEND  NOTIF TO WEB
      Notif().sendNotifToTopic(
          "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${task.sendTo!.removeAllWhitespace.toLowerCase()}",
          task.sendTo!,
          '${cUser.data.name} : "${task.location} - ${task.title}"',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
      //SEND  NOTIF TO ID TASK
      Notif().sendNotifToTopic(
          task.id!.toLowerCase(),
          task.sendTo!,
          '${cUser.data.name} : "${task.location} - ${task.title}"',
          task.id!,
          task.typeReport!,
          imageUrl,
          task.status!,
          "comment",
          task.location!,
          task.sendTo!,
          cUser.data.hotel!);
    }
  }

//funtion untuk terima....................................................
  //to update how many requests are accepted by this user
  int _acceptedTotal = 0;
  int get acceptedTotal => _acceptedTotal;
  int _closeTotal = 0;
  int get closeTotal => _closeTotal;
  getTotalAcceptedAndClose() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .get();
    _closeTotal = userDoc['closeRequest'];
    _acceptedTotal = userDoc['acceptRequest'];
    print('this is total request are accepted by this user $_acceptedTotal');
    print('this is total request are close by this user $_closeTotal');
    notifyListeners();
  }

  int? _newTotalAccepted;
  int? get newTotalAccepted => _newTotalAccepted;
  addNewAcceptedTotal(BuildContext context, int addOne) {
    if (_newTotalAccepted == null) {
      _newTotalAccepted = _acceptedTotal + addOne;
      notifyListeners();
    } else {
      _newTotalAccepted = (newTotalAccepted! + addOne);
      notifyListeners();
    }
  }

  Future<void> accept(
    BuildContext context,
    TaskModel task,
    String msg,
    String collection,
    String changestatus,
    ScrollController scroll,
  ) async {
    await FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotel)
        .collection(collection)
        .doc(task.id)
        .update({
      "status": changestatus,
      'isFading': true,
      "receiver": "${cUser.data.name}",
      "emailReceiver": cUser.data.email,
    });
    await db.updateChat(
      taskmodel: task,
      commentId: const Uuid().v4(),
      taskId: task.id,
      aceepted: msg,
      collection: collection,
    );
    changeStatus(changestatus, "${cUser.data.name}", '');
    if (!task.assigned!.contains(cUser.data.name)) {
      Notif().saveTopic(task.id!.toLowerCase());
    } else {
      print("You are already as a target audience");
    }
    addNewAcceptedTotal(context, 1);
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection(collection)
            .doc(task.id)
            .update({'isFading': false});
      },
    );
    var result = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(task.emailSender)
        .get();
    String token = result.data()!["token"];

    Notif().sendNotifToToken(
        token,
        task.sendTo!,
        "${cUser.data.name} has accept this request: ${task.location} - ${task.title}",
        "",
        task.id!,
        task.typeReport!,
        task.status!,
        "Accepted");
    notifyListeners();
    scrollMaxExtend(scroll);
  }

//function untuk assign....................................................
  TextEditingController searchController = TextEditingController();

  List<UserDetails> users = [];
  List<Departement> departments = [];
  String selectedDept = '';
  String selectedName = '';
  String selectedEmail = '';
  List<String> receiverAssignment = [];
  List<String> names = [];
  List<bool>? boolLlistemployee;
  List<String> emailList = [];
  bool _isGroup = true;
  bool get isGroup => _isGroup;
  int _radioValue = 0;
  int get radioValue => _radioValue;

  String _textInput = '';
  String get textInput => _textInput;

  void searchFuntion(String value) {
    _textInput = value;
    notifyListeners();
  }

  void valueRadio0() {
    _radioValue = 0;
    _isGroup = true;
    notifyListeners();
  }

  void valueRadio1() {
    _radioValue = 1;
    _isGroup = false;
    notifyListeners();
  }

  List<String> departmentsAndNamesSelected = [];
  List<UserDetails> listUser = [];
  List<bool> statusDutyList = [];
  bool _isSwitchedGoup = false;
  bool get isSwitchedGoup => _isSwitchedGoup;
  bool _isSwitchedEmpolyee = false;
  bool get isSwitchedEmpolyee => _isSwitchedEmpolyee;

  void selectFucntionEmployee(bool value, int index) {
    boolLlistemployee![index] = value;
    if (boolLlistemployee![index]) {
      selectedName = users[index].name!;
      selectedEmail = users[index].email!;
      departmentsAndNamesSelected.addAll([users[index].name!]);
      listUser.addAll([users[index]]);
    } else {
      departmentsAndNamesSelected.remove(users[index].name);
      listUser.remove(users[index]);
      selectedName = '';
      selectedEmail = '';
    }
    // _isSwitchedEmpolyee = value;
    print("$selectedName ini name yg terpilih");
    print("$listUser ini email yg terpilih");
    print("$departmentsAndNamesSelected ini name yg masuk list");
    notifyListeners();
  }

  List<bool>? boolLlistGroup;
  Future getDeptartementAndNames() async {
    _isLoading = true;
    notifyListeners();
    //get the list of employees name
    var resultName = await FirebaseFirestore.instance
        .collection("users")
        .where("hotel", isEqualTo: cUser.data.hotel)
        .get();
    users = resultName.docs.map((e) => UserDetails.fromJson(e.data())).toList();
    boolLlistemployee = List.filled(users.length, false);
    //get the list of departments
    var resultDept = await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotel)
        .collection("Department")
        .get();

    departments =
        resultDept.docs.map((e) => Departement.fromJson(e.data())).toList();
    boolLlistGroup = List.filled(departments.length, false);
    _isLoading = false;
    notifyListeners();
  }

  List<Departement> listDept = [];
  void selectFucntionGroup(bool value, int index) {
    boolLlistGroup![index] = value;
    if (boolLlistGroup![index]) {
      selectedDept = departments[index].departement!;
      departmentsAndNamesSelected.addAll([departments[index].departement!]);
      listDept.addAll([departments[index]]);
    } else {
      departmentsAndNamesSelected.remove(departments[index].departement);
      listDept.remove(departments[index]);
      selectedDept = '';
    }
    print("$departmentsAndNamesSelected semua yang terpilih");

    notifyListeners();
  }

  void clearListAssign() {
    searchController.clear();
    departments.clear();
    selectedDept = '';
    selectedName = '';
    selectedEmail = '';
    departmentsAndNamesSelected.clear();
    _textInput = '';
    names.clear();
    listDept.clear();
    listUser.clear();
    statusDutyList.clear();
    _isSwitchedEmpolyee = false;
    _isSwitchedGoup = false;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> assign(
      BuildContext context, TaskModel task, ScrollController scroll) async {
    try {
      _isLoading = true;
      await FirebaseFirestore.instance
          .collection('Hotel List')
          .doc(cUser.data.hotel)
          .collection('tasks')
          .doc(task.id)
          .update({
        "status": "Assigned",
        'isFading': true,
        "assigned": FieldValue.arrayUnion(departmentsAndNamesSelected),
      });
      db.updateChat(
          taskmodel: task,
          commentId: const Uuid().v4(),
          taskId: task.id,
          commentText:
              "${cUser.data.name} has assigned this request to ${departmentsAndNamesSelected.last}",
          assignTo: departmentsAndNamesSelected.join(', '),
          collection: 'tasks');
      changeStatus("Assigned", '', departmentsAndNamesSelected.last.toString());
      Future.delayed(
        const Duration(seconds: 4),
        () async {
          FirebaseFirestore.instance
              .collection('Hotel List')
              .doc(cUser.data.hotel)
              .collection('tasks')
              .doc(task.id)
              .update({'isFading': false});
        },
      );
      if (listUser.isNotEmpty) {
        listUser.forEach((element) async {
          print(
              "${element.email}------------------------------------------------------------------- yang di looping");

          String tokens = element.token!;
          if (tokens.isNotEmpty) {
            Notif().sendNotifToToken(
                tokens,
                "${element.department}",
                "${cUser.data.name} has assigned this request to you: ${task.location} - ${task.title}",
                "",
                task.id!,
                task.typeReport!,
                task.status!,
                "Assigned");
          }
        });
      }
      if (listDept.isNotEmpty) {
        //SENDING NOTIFCATION TO DEPT
        for (var i = 0; i < listDept.length; i++) {
          var receivingUserList = listDept[i].receivingUser;

          if (receivingUserList != null &&
              receivingUserList.isNotEmpty &&
              receivingUserList[0]["id"] != null) {
            String topicToAssign = receivingUserList[0]["id"];
            print(topicToAssign);
            Notif().sendNotifToTopic(
                topicToAssign,
                "${listDept[i].departement}",
                "${cUser.data.name} has assigned this request to you: ${task.location} - ${task.title}",
                task.id!,
                task.typeReport!,
                "",
                task.status!,
                "Assigned",
                task.location!,
                task.sendTo!,
                cUser.data.hotel!);
            Notif().sendNotifToTopic(
                "${user.data.hotel!.removeAllWhitespace.toLowerCase()}_${listDept[i].departement!.removeAllWhitespace.toLowerCase()}",
                "${listDept[i].departement}",
                "${user.data.name} has assigned this request to you: ${task.location} - ${task.title}",
                task.id!,
                task.typeReport!,
                "",
                task.status!,
                "Assigned",
                task.location!,
                task.sendTo!,
                cUser.data.hotel!);
          }
        }
      }
    } catch (e) {
      ShowDialog().errorDialog(context, "Ups, something wrong!");
    } finally {
      _isLoading = false;
      clearListAssign();
      // Navigator.pop(context);
      scrollMaxExtend(scroll);
      notifyListeners();
    }
  }

  //function untuk close task....
  int? _newTotalClose;
  int? get newTotalClose => _newTotalClose;
  addNewCloseTotal(BuildContext context, int addOne) {
    if (_newTotalClose == null) {
      _newTotalClose = _closeTotal + addOne;
      notifyListeners();
    } else {
      _newTotalClose = (newTotalClose! + addOne);
      notifyListeners();
    }
  }

  String finishingTime(TaskModel task) {
    var timeCreate = task.time;
    var diffTime = DateTime.now().toUtc().difference(timeCreate!.toDate());
    if (diffTime.inHours > 24) {
      return "${diffTime.inDays} day";
    } else if (diffTime.inDays > 1) {
      return "${diffTime.inDays} days";
    } else if (diffTime.inMinutes > 60) {
      int sisaMenit = diffTime.inMinutes % 60;
      return "${diffTime.inHours} hour $sisaMenit m";
    } else if (diffTime.inHours > 1) {
      int sisaMenit = diffTime.inMinutes % 60;
      return "${diffTime.inHours} hours $sisaMenit m";
    }
    return "${diffTime.inMinutes} mnt";
  }

  Future<void> close(
    BuildContext context,
    TaskModel task,
    ScrollController scroll,
    String reason,
  ) async {
    var senderData = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(task.emailSender)
        .get();
    UserDetails userData = UserDetails.fromJson(senderData.data()!);
    await FirebaseFirestore.instance
        .collection(hotelCollection)
        .doc(cUser.data.hotel)
        .collection(collectionTasks)
        .doc(task.id)
        .update({
      "status": "Close",
      'isFading': true,
      'closeTime': DateTime.now().toUtc().toString(),
      "receiver": cUser.data.name,
      "resolusi": finishingTime(task),
    });
    db.updateChat(
      taskmodel: task,
      collection: task.typeReport!,
      commentId: const Uuid().v4(),
      commentText: reason.isNotEmpty
          ? "has close this request\n$reason"
          : "has close this request",
      taskId: task.id,
    );
    changeStatus("Close", cUser.data.name!, "");
    addNewCloseTotal(context, 1);
    FirebaseFirestore.instance
        .collection('users')
        .doc(cUser.data.email)
        .update({'closeRequest': newTotalClose});
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(task.id)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    if (!task.assigned!.contains(cUser.data.name)) {
      Notif().saveTopic(task.id!.toLowerCase());
    } else {
      print("You are as a traget audience");
    }
    Navigator.pop(context);
    if (reason.isNotEmpty) {
      if (userData.token != null) {
        Notif().sendNotifToToken(
            userData.token!,
            task.sendTo!,
            "${cUser.data.name} has close this request: ${task.location} - ${task.title}\n$reason",
            "",
            task.id!,
            task.typeReport!,
            task.status!,
            "Close");
      }
    } else {
      if (userData.token != null) {
        Notif().sendNotifToToken(
            userData.token!,
            task.sendTo!,
            "${cUser.data.name} has close this request: ${task.location} - ${task.title}",
            "",
            task.id!,
            task.typeReport!,
            task.status!,
            "Close");
      }
    }
    notifyListeners();
    scrollMaxExtend(scroll);
  }

  //reopen task.....
  Future<void> reopen(
    BuildContext context,
    TaskModel taskModel,
    ScrollController scroll,
  ) async {
    var senderData = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(taskModel.emailSender)
        .get();
    UserDetails userData = UserDetails.fromJson(senderData.data()!);
    await FirebaseFirestore.instance
        .collection(hotelCollection)
        .doc(cUser.data.hotel)
        .collection("tasks")
        .doc(taskModel.id)
        .update({
      "status": "Reopen",
      'isFading': true,
      "receiver": cUser.data.name,
    });
    db.updateChat(
        taskmodel: taskModel,
        taskId: taskModel.id,
        commentId: const Uuid().v4(),
        commentText: 'has reopen this request',
        collection: taskModel.typeReport!);
    changeStatus("Reopen", cUser.data.name!, "");
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskModel.id)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    if (!taskModel.assigned!.contains(cUser.data.name)) {
      Notif().saveTopic(taskModel.id!.toLowerCase());
    } else {
      print("You are target audience");
    }
    Notif().sendNotifToToken(
        userData.token!,
        '${taskModel.location} - "${taskModel.title}"',
        "${cUser.data.name} has reopen this request: ${taskModel.location} - ${taskModel.title}",
        taskModel.id!,
        taskModel.typeReport!,
        taskModel.typeReport!,
        taskModel.status!,
        "Reopen");

    Notif().sendNotifToTopic(
        taskModel.id!,
        '${taskModel.location} - "${taskModel.title}"',
        "${cUser.data.name} has reopen this request: ${taskModel.location} - ${taskModel.title}",
        taskModel.id!,
        taskModel.typeReport!,
        imageUrls.first,
        taskModel.status!,
        "Reopen",
        taskModel.location!,
        taskModel.sendTo!,
        cUser.data.hotel!);
    clearListAssign();
    scrollMaxExtend(scroll);
    notifyListeners();
  }

  Future<void> changeValueOfFading(String taskId) async {
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        FirebaseFirestore.instance
            .collection('Hotel List')
            .doc(cUser.data.hotel)
            .collection('tasks')
            .doc(taskId)
            .update({'isFading': false});
        notifyListeners();
      },
    );
    notifyListeners();
  }

  //this is function for lf chat
  List totalEmailAdmin = [];
  getAdminData() async {
    var result = await FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotel)
        .get();
    List<dynamic> dataAdmin = result.data()!["admin"];
    dataAdmin.forEach((element) {
      List list = element['housekeeping'];
      // print(list);
      list.forEach((element) async {
        var getToken = await FirebaseFirestore.instance
            .collection("users")
            .doc(element)
            .get();
        List listToken = getToken['token'];
        listToken.forEach((element) {
          print(element);
        });
      });
    });
    notifyListeners();
  }

  void saveNetworkImage(String url) async {
    print("----------------------");
    print("save network image");
    final temDir = await getTemporaryDirectory();
    final path = '${temDir.path}/myfile.jpg';
    // await Dio().download(url, path);
    final respon = await http.get(Uri.parse(url));
    final bytes = respon.bodyBytes;
    File(path).writeAsBytesSync(bytes);
    // var result = await GallerySaver.saveImage(path, albumName: "POST");
    // print("Hasil: $result");
    // if (result == true) {
    //   Fluttertoast.showToast(
    //       msg: "Image Saved",
    //       textColor: Colors.green.shade900,
    //       backgroundColor: Colors.white);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Failed to download",
    //       textColor: Colors.red.shade900,
    //       backgroundColor: Colors.white);
    // }
  }

  int current = 0;
  final CarouselController controller = CarouselController();
  void currentIndex(int index) {
    current = index;
    notifyListeners();
  }
}
