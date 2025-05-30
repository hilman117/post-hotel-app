// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

import '../../fireabase_service/fcm_service.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../service/session_user.dart';
import '../../variable.dart';
import '../homescreen/home.dart';

class SignInController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserDetails? userDetails;
  bool _isSave = box!.get('isSave') ?? false;
  bool get isSave => _isSave;
  final String _getEmail = box!.get('email') ?? '';
  String get getEmail => _getEmail;
  final String _getPassword = box!.get('password') ?? '';
  String get getPassword => _getPassword;

  isSaveValue(bool value) {
    _isSave = !_isSave;
    box!.putAll({'isSave': _isSave});
    notifyListeners();
  }

  Future signIn(BuildContext context, String email, String password) async {
    final applications = AppLocalizations.of(context);
    final homeController = Provider.of<HomeController>(context, listen: false);
    if (email.isEmpty || !email.contains("@")) {
      return Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: applications!.emailFormatNotValid,
          textColor: mainColor,
          backgroundColor: Colors.grey.shade200);
    }
    if (password.isEmpty) {
      return Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: applications!.passwordMustBeFilled,
          textColor: mainColor,
          backgroundColor: Colors.grey.shade200);
    } else {
      try {
        loading(context);
        // String currentEmail = await box!.get('email');
        // String currentPassword = await box!.get('password');
        if (_isSave) {
          await box!.putAll({'email': email});
          await box!.putAll({'password': password});
        } else {
          box!.delete('email');
          box!.delete('password');
        }
        await auth.signInWithEmailAndPassword(
            email: email.removeAllWhitespace,
            password: password.removeAllWhitespace);
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.email)
            .get();
        if (userDoc.data() != null) {
          userDetails =
              UserDetails.fromJson(userDoc.data() as Map<String, dynamic>);
          SessionsUser.saveUser(userDetails!);
          String? token = await Notif().getToken();
          box!.put('token', token);
          box!.put('email', auth.currentUser!.email);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(auth.currentUser!.email)
              .update({"token": token});
          print("TOKEN BARU $token");
          var dataDept = await FirebaseFirestore.instance
              .collection(hotelCollection)
              .doc(userDetails!.hotel)
              .collection(collectionDepartement)
              .get();
          List<Departement> listDept =
              dataDept.docs.map((e) => Departement.fromJson(e.data())).toList();
          await homeController.getAllReceivingUsers(listDept);
          Get.offAll(() => const HomeScreen(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 700));
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: "${applications!.youAreSignInAs} ${userDetails!.name}",
              textColor: Colors.black,
              backgroundColor: Colors.grey.shade50);
          // final hotelName = userDetails!.hotel;

          // final url = Uri.parse(
          //     'https://us-central1-post-app-d6f0c.cloudfunctions.net/escalateTasks');
          // final response = await http.post(url,
          //     headers: {
          //       'Content-Type': 'application/json',
          //     },
          //     body: jsonEncode({
          //       'hotelName': hotelName,
          //     }));

          // if (response.statusCode == 200) {
          //   print('Tasks escalated successfully');
          // } else {
          //   print('Error escalating tasks: ${response.statusCode}');
          // }
          // List<Departement> list =
          //     Provider.of<List<Departement>>(context, listen: false);
          // Future.microtask(() =>
          //     Provider.of<HomeController>(context, listen: false)
          //         .getAllReceivingUsers(list));
        }

        // Navigator.of(context)
        //     .pushReplacement(MaterialPageRoute(builder: (context) {
        //   return const MasterAdmin();
        // }));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: applications!.noUserFoundForThatEmail,
              textColor: mainColor,
              backgroundColor: Colors.grey.shade200);
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: applications!.wrongPasswordProvidedForThatUser,
              textColor: mainColor,
              backgroundColor: Colors.grey.shade200);
        }
      }
    }
  }
}
