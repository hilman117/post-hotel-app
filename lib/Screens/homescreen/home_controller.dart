import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/Screens/example/general_widget.dart';
import 'package:post_app/core.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/models/hotel_data_model.dart';
import 'package:post_app/variable.dart';

import '../../common_widget/loading.dart';
import '../../controller/c_user.dart';
import '../../fireabase_service/firebase_read_data.dart';
import '../../main.dart';
import '../../models/titles_model.dart';

class HomeController with ChangeNotifier {
  final readData = FirebaseReadData();
  final firebaseAuth = FirebaseAuth.instance;

  int indexScreen = 0;
  void selectScreens(int screen, CupertinoTabController tab) {
    indexScreen = screen;
    tab.index = indexScreen;
    canPopOut = false;
    notifyListeners();
  }

  bool canPopOut = false;
  void getOutFromTheApp(bool value) {
    canPopOut = value;
    notifyListeners();
  }

  List<Pages> pages = [
    Pages(
        color: Colors.blue,
        iconPage: Platform.isIOS
            ? CupertinoIcons.list_bullet_indent
            : Icons.dashboard_outlined,
        labelPages: "Dashboard"),
    Pages(
        color: Colors.orange,
        iconPage: Platform.isIOS
            ? CupertinoIcons.tray_2_fill
            : Icons.admin_panel_settings_outlined,
        labelPages: "Admin"),
    Pages(
        color: Colors.red,
        iconPage: Platform.isIOS
            ? CupertinoIcons.chart_pie_fill
            : Icons.analytics_outlined,
        labelPages: "Report"),
    Pages(
        color: Colors.green,
        iconPage: Platform.isIOS
            ? CupertinoIcons.archivebox_fill
            : Icons.location_disabled_outlined,
        labelPages: "Lost And Found"),
    Pages(
        color: Colors.grey, iconPage: Icons.key, labelPages: "Change Password"),
    Pages(
        color: Colors.purple,
        iconPage: Platform.isIOS
            ? CupertinoIcons.arrow_up_right_square_fill
            : Icons.logout_outlined,
        labelPages: "Log out"),
  ];

  //this is how to filter request depend on which tab that selected
  String mine = "Mine";
  String open = "Open";
  void filterLabel(String label) {
    mine = label;
    notifyListeners();
  }

  void filterStatus(String status) {
    open = status;
    notifyListeners();
  }

  //sorting method for ios

  bool mineValue = true;
  bool openValue = true;
  String sortByMine = "Mine";
  String sortByClose = "Open";

  void mineAll(bool newValue) {
    mineValue = newValue;

    if (mineValue) {
      sortByMine = " Mine";
    } else {
      sortByMine = "All";
    }
    // print(mineValue);
    notifyListeners();
  }

  void openClose(BuildContext context, bool newValue) {
    openValue = newValue;
    if (openValue) {
      sortByClose = "Open";
    } else {
      sortByClose = "Close";
      getCloseTasks(context);
    }
    notifyListeners();
  }

  //to get data tasks that with close status
  List<TaskModel> listTasksClose = [];

  Future<void> getCloseTasks(BuildContext context) async {
    try {
      // Show loading when fetching data from Firestore
      loading(context);

      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> value =
          await readData.getCloseTask(user.data.department!, listDepartement!);

      // Map documents to TaskModel
      listTasksClose =
          value.docs.map((e) => TaskModel.fromJson(e.data())).toList();
      // Close loading
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      // Notify listeners
      notifyListeners();
    } catch (error) {
      // Handle errors (print or show an error message)
      print("Error fetching close tasks: $error");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close loading
      // Handle the error accordingly, e.g., show an error message
    }
  }

  //get all close tasks data with specific department
  Future<void> getDepartementCloseTasks(
      BuildContext context, String dept) async {
    try {
      // Show loading when fetching data from Firestore
      loading(context);

      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> value =
          await readData.getDepartementCloseTask(dept);

      // Map documents to TaskModel
      listTasksClose =
          value.docs.map((e) => TaskModel.fromJson(e.data())).toList();

      // Close loading
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      // Notify listeners
      notifyListeners();
    } catch (error) {
      // Handle errors (print or show an error message)
      print("Error fetching close tasks: $error");
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close loading
      // Handle the error accordingly, e.g., show an error message
    }
  }

  List<TaskModel> filteredListTasks = [];

  List<TaskModel> filteredTasks(CUser user, List<TaskModel> defaultListTasks,
      List<Departement> listDept) {
    List<String> receiverFor = [];

    for (var index = 0; index < listDept.length; index++) {
      var receivingUsers = listDept[index].receivingUser;
      if (receivingUsers != null) {
        //MEMFILTER DEPARTEMENT YANG DI DALAM RECEIVER NYA TERDAPAT NAMA USER
        for (var i = 0; i < receivingUsers.length; i++) {
          var data = receivingUsers[i]["receiver"] as List?;
          if (data != null && data.contains(user.data.name)) {
            receiverFor.add(listDept[index].departement!);
          }
        }
      }
    }
    if (mineValue && openValue) {
      //MINE OPEN REQUEST
      filteredListTasks = defaultListTasks.where((task) {
        return (task.assigned != null &&
                task.assigned!.any((assignee) =>
                    receiverFor.contains(assignee) ||
                    assignee == user.data.name!)) ||
            task.sender == user.data.name;
      }).toList();
    } else if (mineValue && !openValue) {
      //SHOW MINE CLOSE REQUEST
      filteredListTasks = listTasksClose.where((task) {
        return (task.assigned != null &&
                task.assigned!.any((assignee) =>
                    receiverFor.contains(assignee) ||
                    assignee == user.data.name!)) ||
            task.sender == user.data.name;
      }).toList();
    } else if (!mineValue && !openValue) {
      //SHOW ALL CLOSE REQUEST
      filteredListTasks = listTasksClose;
    } else {
      filteredListTasks = defaultListTasks;
    }
    filteredListTasks.sort(
      (a, b) => b.time!.compareTo(a.time!),
    );
    return filteredListTasks;
  }

  // to collapsing the search button
  bool _isCollaps = false;
  bool get isCollapse => _isCollaps;
  void changeValue() async {
    _isCollaps = !_isCollaps;
    notifyListeners();
  }

  String _textInput = '';
  String get textInput => _textInput;
  final TextEditingController text = TextEditingController();
  void getInputTextSearch(String value) {
    _textInput = value;
    notifyListeners();
  }

  bool isLoading = false;
  Future<void> getAllReceivingUsers(List<Departement> departments) async {
    // if (dataHotel!.hotelid != null) {
    //   print("subscribing to ${dataHotel!.hotelid}${user.data.department}");
    //   await Notif().saveTopic("${dataHotel!.hotelid}${user.data.department}");
    // }
    List<Map<String, dynamic>> allReceivingUsers = [];
    // Map<String, dynamic> data = {};
    for (Departement department in departments) {
      if (department.receivingUser != null) {
        allReceivingUsers.addAll(department.receivingUser!);
      }
    }
    if (allReceivingUsers.isNotEmpty) {
      for (Map<String, dynamic> element in allReceivingUsers) {
        List<String> listUser = List<String>.from(element["receiver"]);
        if (listUser.any((name) => name == user.data.name)) {
          Notif().saveTopic(element["id"]);

          // Ambil list yang sudah ada
          List<String> currentList =
              List<String>.from(box!.get("subscribetion") ?? []);

          // Cek apakah topic sudah ada
          if (!currentList.contains(element["id"])) {
            currentList.add(element["id"]);
            await box!.put("subscribetion", currentList);
          }

          print("Daftar topik langganan: $currentList");
        }
      }
    }

    notifyListeners();
  }

  // update status duty
  bool? _isOnduty;
  bool? get isOnduty => _isOnduty;
  void changeDutyStatus(bool value) {
    _isOnduty = value;
    box!.putAll({'dutyStatus': value});
    notifyListeners();
  }

  GeneralData? dataHotel;
  List<String> listLocation = [];
  List titles = [];
  String? imageHOtel = "";
  List<TitlesModel> listTitle = [];
  Future<void> getDataHotel() async {
    try {
      isLoading = true;
      await db
          .getHotelData()
          .then((value) => dataHotel = GeneralData.fromJson(value.data()!));
      listLocation = dataHotel!.location!;

      notifyListeners();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //get list of Departement
  List<Departement>? listDepartement = [];
  Future<void> getDepartementList() async {
    listDepartement = await db.getListDepartement();
    notifyListeners();
  }

  //method to check user is admin or not

  bool isAuthorized() {
    if (cUser.data.accountType == "Dept. Admin") {
      return true;
    }
    if (cUser.data.accountType == "Administrator") {
      return true;
    }
    return false;
  }

  Future<int> getLenghtComment(String idTask) async {
    int data = 0;
    var lenghtComment = FirebaseFirestore.instance
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionTasks)
        .doc(idTask)
        .collection("comment")
        .get();
    return lenghtComment.then((value) {
      data = value.docs.length;
      debugPrint(data.toString());

      notifyListeners();
      return data;
    });
    // return data;
  }

  void addLenght() {
    // data = data + 1;
    notifyListeners();
  }
}

class Pages {
  IconData? iconPage;
  String? labelPages;
  Color? color;

  Pages(
      {required this.iconPage, required this.labelPages, required this.color});
}
