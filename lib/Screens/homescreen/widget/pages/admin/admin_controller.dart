// ignore_for_file: use_build_context_synchronously

import 'package:acronym/acronym.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/common_widget/show_dialog.dart';
import 'package:post_app/core.dart';
import 'package:post_app/extensions.dart';
import 'package:post_app/fireabase_service/firebase_post_data.dart';
import 'package:post_app/fireabase_service/firebase_read_data.dart';
import 'package:post_app/fireabase_service/firebase_update_data.dart';
import 'package:provider/provider.dart';

class AdminController with ChangeNotifier {
  FirebaseReadData read = FirebaseReadData();
  FirebasePostData post = FirebasePostData();
  FirebaseUpdateData update = FirebaseUpdateData();
  //get list data of employee
  List<UserDetails> listEmployee = [];
  Future<void> getEmployeeData(BuildContext context) async {
    try {
      loading(context);
      await read.getListEmployee().then((value) => listEmployee =
          value.docs.map((e) => UserDetails.fromJson(e.data())).toList());
      print(listEmployee);
      Navigator.of(context).pop();
      notifyListeners();
    } catch (e) {
      Navigator.of(context).pop();
      ShowDialog().errorDialog(context, "Something Wrong, try again later");
      print('Error while getting employee data: $e');
      rethrow;
    }
  }

  String departement = "Select Departement";
  void selectDepartement(BuildContext context, String dept) {
    departement = dept;
    Navigator.pop(context);
    print(departement);
    notifyListeners();
  }

  //select role of user [ADMIN ATAU BUKAN ADMIN]
  List<String> role = ["User", "Dept. Admin", "Administrator"];
  String roleSelected = "User";
  List<String> userColor = [
    "0xFFB71C1C",
    "0xFF0D47A1",
    "0xFF1B5E20",
    "0xFF212121",
    "0xff283593",
    "0xff1565C0",
    "0xff00838F",
    "0xff00695C",
    "0xff2E7D32",
    "0xff9E9D24",
    "0xffF9A825",
    "0xffEF6C00",
    "0xff78909C"
  ];
  void selectRole(BuildContext context, String selectedRole) {
    roleSelected = selectedRole;
    Navigator.pop(context);
    notifyListeners();
  }

  String deptCode = "";
  getDeptCode(String dept) {
    var words = dept.split(" ");
    if (words.length < 2 && dept == "Housekeeping") {
      deptCode = dept.toAcronym(splitSyllables: true);
      notifyListeners();
    } else if (words.length > 1) {
      deptCode = dept.toAcronym(stopWords: []);
      notifyListeners();
    } else {
      deptCode = dept.substring(0, 3);
      notifyListeners();
    }
    notifyListeners();
  }

  TextEditingController emailText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  Future createAccount({
    required BuildContext context,
    required String domainEmail,
    required String role,
    required String hotel,
    required String dept,
    required String colorsUser,
  }) async {
    final theme = Theme.of(context);
    if (emailText.text == "") {
      return ShowDialog().alerDialog(context, "Please to complete the email");
    }
    if (passwordText.text == "") {
      return ShowDialog()
          .alerDialog(context, "Please to complete the password");
    } else {
      try {
        loading(context);
        await getDeptCode(dept);
        await post.createAccount(
            email: emailText.text.toLowerCase() + domainEmail,
            password: passwordText.text,
            name: "(${deptCode.toUpperCase()}) ${nameText.text.toTitleCase()}",
            departement: dept,
            role: role,
            hotel: hotel,
            colorsUser: colorsUser);
        Navigator.of(context).pop();
        emailText.clear();
        nameText.clear();
        role = "User";
        passwordText.clear();
        getEmployeeData(context);
        Fluttertoast.showToast(
            msg: "Succed create account",
            textColor: theme.focusColor,
            backgroundColor: theme.scaffoldBackgroundColor);
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();

        if (e.code == 'weak-password') {
          ShowDialog()
              .alerDialog(context, "The password provided is too weak.");
          notifyListeners();
        } else if (e.code == 'email-already-in-use') {
          ShowDialog()
              .alerDialog(context, "The account already exists for that email");
          notifyListeners();
        }
      } catch (e) {
        Navigator.of(context).pop();
        ShowDialog().alerDialog(
            context, "Something went wrong, please try again later");
        // ignore: avoid_print
        print(e);
      }
    }
    notifyListeners();
  }

  //edit account
  TextEditingController editname = TextEditingController();
  Future editProfile({
    required BuildContext context,
    required String name,
    required String email,
    required String role,
    required String editDept,
    required String hotel,
  }) async {
    final theme = Theme.of(context);
    try {
      loading(context);
      await getDeptCode(editDept);
      await update.updateProfile(
          name: editname.value.text.isEmpty
              ? name
              : "(${deptCode.toUpperCase()}) ${editname.text.toTitleCase()}",
          email: email,
          departement: editDept,
          role: role);
      Navigator.of(context).pop();

      role = "User";
      departement = "Select Departement";
      getEmployeeData(context);
      Fluttertoast.showToast(
          msg: "Succed edit profile",
          textColor: theme.focusColor,
          backgroundColor: theme.scaffoldBackgroundColor);
    } catch (e) {
      Navigator.of(context).pop();
      ShowDialog()
          .alerDialog(context, "Something went wrong, please try again later");
      // ignore: avoid_print
      print(e);
    }
    editname.clear();
    notifyListeners();
  }

  //delete user
  Future deleteUser({
    required BuildContext context,
    required String name,
    required String email,
  }) async {
    final theme = Theme.of(context);
    try {
      loading(context);
      await update.deleteUser(email: email);
      Navigator.of(context).pop();
      getEmployeeData(context);
      Fluttertoast.showToast(
          msg: "$name deleted success",
          textColor: theme.focusColor,
          backgroundColor: theme.scaffoldBackgroundColor);
    } catch (e) {
      Navigator.of(context).pop();
      ShowDialog()
          .alerDialog(context, "Something went wrong, please try again later");
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }

  //update departement
  Future updateActiveDepartement(
      {required BuildContext context,
      required String hotel,
      required bool newValue,
      required String departement}) async {
    final homeCon = Provider.of<HomeController>(context, listen: false);
    try {
      loading(context);
      await update.updateActiveDepartement(
          hotelName: hotel, department: departement, newValue: newValue);
      await homeCon.getDepartementList();
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
      ShowDialog()
          .alerDialog(context, "Something went wrong, please try again later");
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }

  List<String> departementIcon = [
    "images/Engineering.png",
    "images/Entertainment.png",
    "images/Front Office.png",
    "images/IT Support.png",
    "images/Room Service.png",
    "images/Housekeeping.png",
    "images/Butler.png",
    "images/Concierge.png",
    "images/entertain-2.png",
    "images/guard.png",
    "images/hr-manager.png",
    "images/laundry.png",
    "images/hotel-bell.png",
    "images/kitchen-utensils.png",
    "images/police.png",
    "images/chef.png",
    "images/menu.png"
  ];

  String selectedIcon = "";
  void selecIcon(BuildContext context, String icon) {
    selectedIcon = icon;
    notifyListeners();
  }

  TextEditingController editDeptName = TextEditingController();

  //toggle button
  bool isActive = false;
  void activateButton(bool value) {
    isActive = value;
    notifyListeners();
  }

  //delete departement
  Future deleteDepartement(
      BuildContext context, String departement, String hotel) async {
    final homeCon = Provider.of<HomeController>(context, listen: false);
    loading(context);
    await update.deleteDepartemet(hotelName: hotel, department: departement);
    await homeCon.getDepartementList();
    Navigator.of(context).pop();
  }

  //expansion tile on title card [add title]
  TextEditingController inputNewTitle = TextEditingController();
  String newTitle = "";

  bool isCollapseTitle = false;
  bool isCollapseLocation = false;
  void colapsingPanel({bool? valueTitle, bool? valueLocation}) {
    isCollapseTitle = valueTitle ?? false;
    isCollapseLocation = valueLocation ?? false;
    notifyListeners();
  }

  Future addTitle(
      BuildContext context, String hotel, String departement) async {
    loading(context);
    final homeCon = Provider.of<HomeController>(context, listen: false);
    await update.updateTitle(
        hotelName: hotel,
        department: departement,
        newTitle: inputNewTitle.text);
    await homeCon.getDepartementList();
    inputNewTitle.clear();
    isCollapseTitle = false;
    Navigator.of(context).pop();
    notifyListeners();
  }

//delete title, masih belum sempurna ......................................................
  List<String> lisTitle = [];
  Future deleteTitle(BuildContext context, String hotel, String departement,
      List<String> titleList, int titleToDelete) async {
    loading(context);
    final homeCon = Provider.of<HomeController>(context, listen: false);
    //hapus title yang dipilih
    titleList.removeAt(titleToDelete);
    // setelah title yang dipilih terhapus kemudian masukan lagi ke firestore
    await update.updateTitle(
        hotelName: hotel, department: departement, titleList: titleList);
    await homeCon.getDepartementList();
    inputNewTitle.clear();
    isCollapseTitle = false;
    Navigator.of(context).pop();
    notifyListeners();
  }

  //create new departement
  TextEditingController inputNameDepartement = TextEditingController();
  String newDept = "";
  Future createDepartement(
      BuildContext context, String hotelName, String color) async {
    final homeCon = Provider.of<HomeController>(context, listen: false);
    try {
      if (selectedIcon == "" || newDept == "") {
        ShowDialog()
            .alerDialog(context, "Name of Departement or icon is not valid");
      } else {
        loading(context);
        await post.createDepartement(hotelName, newDept, color, selectedIcon);
        await homeCon.getDepartementList();
        inputNameDepartement.clear();
        newDept = "";
        selectedIcon = "";
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "departement success created");
      }
    } catch (e) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Something wrong!");
      print(e);
    }
  }

  //input new location
  TextEditingController newLocation = TextEditingController();
  String location = "";
  Future addLocation(BuildContext context, String hotel) async {
    final homeCon = Provider.of<HomeController>(context, listen: false);
    if (location.isEmpty) {
      ShowDialog().alerDialog(context, "New location should be defined");
    } else {
      try {
        loading(context);
        await update.addLocation(location, hotel);
        await homeCon.getDataHotel();
        Navigator.of(context).pop();
        cleaner();
      } catch (e) {
        print(e);
      }
    }
  }

  Future deleteLocation(BuildContext context, String hotel,
      List<String> locationList, int targetToDelete) async {
    final homeCon = Provider.of<HomeController>(context, listen: false);
    locationList.removeAt(targetToDelete);
    try {
      loading(context);
      await update.deleteLocation(locationList, hotel);
      await homeCon.getDataHotel();
      Navigator.of(context).pop();
      cleaner();
    } catch (e) {
      print(e);
    }
  }

  void input({String? value, String? deptName, String? newLoc}) {
    newTitle = value ?? "";
    newDept = deptName ?? "";
    location = newLoc ?? "";
    notifyListeners();
  }

  //clear all value of variable
  cleaner() {
    inputNameDepartement.clear();
    titleController.clear();
    userController.clear();
    newLocation.clear();
    locationSearch.clear();
    location = "";
    searchLocation = "";
    searchTitle = "";
    searchUser = "";
    selectedIcon = "";
    notifyListeners();
  }

  //search function
  String searchTitle = "";
  String searchUser = "";
  String searchLocation = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController locationSearch = TextEditingController();
  void searching({String? keywords, String? user, String? location}) {
    searchTitle = keywords ?? "";
    searchUser = user ?? "";
    searchLocation = location ?? "";
    notifyListeners();
  }

//method to select which dept that to assign to keep lost and found
  String deptToKeepLF = "";
  void deptToStoreLF(String dept) {
    deptToKeepLF = dept;
    notifyListeners();
  }
}
