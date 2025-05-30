import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:post_app/core.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:post_app/variable.dart';

import '../controller/c_user.dart';

class FirebaseReadData {
  final db = FirebaseFirestore.instance;
  final user = Get.put(CUser());

//get all tasks data, close and open tasks

  Stream<List<Departement>> getDepartementData() {
    return db
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionDepartement)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs
            .map((docs) => Departement.fromJson(docs.data()))
            .toList());
  }

//Stream task
  Stream<List<TaskModel>> streamTask() {
    return db
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionTasks)
        .where("status", isNotEqualTo: "Close")
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs
            .map((data) => TaskModel.fromJson(data.data()))
            .toList());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCloseTask(
      String department, List<Departement> listDept) async {
    try {
      // Check if the department exists
      Departement? dept = listDept.firstWhere(
        (element) => element.departement == department,
        orElse: () => Departement(),
      );

      // Calculate the date from the retention days ago
      DateTime retentionDate =
          DateTime.now().subtract(Duration(days: dept.retentionDay ?? 2));
      Timestamp retentionTimestamp = Timestamp.fromDate(retentionDate);

      // Query the database
      return await FirebaseFirestore.instance
          .collection(hotelCollection)
          .doc(user.data.hotel)
          .collection(collectionTasks)
          .where('status', isEqualTo: 'Close')
          .where('time', isGreaterThanOrEqualTo: retentionTimestamp)
          .get();
    } catch (e) {
      // Log the error for better debugging
      print("Error fetching close tasks: ${e.toString()}");
      rethrow; // Re-throw the error to handle it further up the call stack if needed
    }
  }

//to get read task specific departement that has been closed
  Future<QuerySnapshot<Map<String, dynamic>>> getDepartementCloseTask(
      String dept) {
    debugPrint(user.data.hotel);
    return db
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionTasks)
        .where("sendTo", isEqualTo: dept)
        .where("status", isEqualTo: "Close")
        .limit(250)
        .get();
  }

  //to get hotel general data
  Future<DocumentSnapshot<Map<String, dynamic>>> getHotelData() async {
    return db.collection(hotelCollection).doc(user.data.hotel).get();
  }

  //get departement title
  Future<List<Departement>> getListDepartement() async {
    return db
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionDepartement)
        .get()
        .then((value) =>
            value.docs.map((e) => Departement.fromJson(e.data())).toList());
  }

  //get departement title
  Future<Departement> getDepartementTitle(String deptSelected) async {
    return db
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionDepartement)
        .doc(deptSelected)
        .get()
        .then((value) => Departement.fromJson(value.data()!));
  }

//to get employee data
  Future<QuerySnapshot<Map<String, dynamic>>> getListEmployee() async {
    return db
        .collection(userCollection)
        .where("hotel", isEqualTo: user.data.hotel)
        .get();
  }

//to get profile data of user
  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileData() async {
    return db.collection(userCollection).doc(user.data.email).get();
  }

//get all lost and found data

  Future<QuerySnapshot<Map<String, dynamic>>> getLostAndFountByName() async {
    return db
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collectionlf)
        .where("sender", isEqualTo: user.data.name)
        .get();
  }
}
