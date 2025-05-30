import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:post_app/extensions.dart';
import 'package:post_app/variable.dart';

class FirebaseUpdateData {
  final db = FirebaseFirestore.instance;
  final user = Get.put(CUser());
  final auth = FirebaseAuth.instance;

//for sending a comment
  Future<void> updateChat(
      {String? taskId,
      String? commentText,
      String? commentId,
      List<String>? imageComment,
      String? aceepted,
      String? assingTask,
      String? assignTo,
      String? description,
      String? esc,
      String? titleChange,
      String? newLocation,
      String? hold,
      String? resume,
      String? setDate,
      String? setTime,
      String? scheduleDelete,
      required TaskModel taskmodel,
      required String collection}) async {
    await FirebaseFirestore.instance
        .collection(hotelCollection)
        .doc(user.data.hotel)
        .collection(collection)
        .doc(taskId)
        .update({
      "comment": FieldValue.arrayUnion([
        {
          "timeSent": DateTime.now().toIso8601String(),
          'accepted': aceepted ?? "",
          'assignTask': assingTask ?? "",
          'assignTo': assignTo ?? "",
          'commentBody': commentText ?? "",
          'commentId': commentId,
          'description': description ?? "",
          'esc': esc ?? "",
          'imageComment': imageComment ?? [],
          'sender': user.data.name,
          'colorUser': user.data.userColor,
          'senderemail': auth.currentUser!.email,
          'setDate': setDate ?? "",
          'setTime': setTime ?? "",
          'time': DateTime.now().toIso8601String(),
          'titleChange': titleChange ?? "",
          'newlocation': newLocation ?? "",
          'hold': hold ?? "",
          'resume': resume ?? "",
          'scheduleDelete': scheduleDelete ?? "",
        }
      ])
    });
  }

  //update user profile
  Future updateProfile({
    String? name,
    required String email,
    String? departement,
    String? role,
    String? password,
  }) async {
    await db.collection(userCollection).doc(email.toLowerCase()).update({
      "name": name ?? user.data.name,
      "department": departement ?? user.data.department,
      "accountType": role ?? user.data.accountType,
      "password": password ?? user.data.password
    });
  }

  //delete user profile
  Future deleteUser({
    required String email,
  }) async {
    await db.collection(userCollection).doc(email.toLowerCase()).delete();
  }

  //update departement
  Future updateActiveDepartement(
      {required String hotelName,
      required String department,
      required newValue}) async {
    await db
        .collection(hotelCollection)
        .doc(hotelName)
        .collection("Department")
        .doc(department)
        .update({"isActive": newValue});
  }

  //delete deprtement
  Future deleteDepartemet({
    required String hotelName,
    required String department,
  }) async {
    await db
        .collection(hotelCollection)
        .doc(hotelName)
        .collection(collectionDepartement)
        .doc(department)
        .delete();
    await db
        .collection(userCollection)
        .where("department", isEqualTo: department)
        .get()
        .then((value) => value.docs.map((e) => e.reference.delete()));
  }

  //update departement
  Future updateTitle(
      {required String hotelName,
      required String department,
      List<String>? titleList,
      String? newTitle}) async {
    if (titleList != null) {
      await db
          .collection(hotelCollection)
          .doc(hotelName)
          .collection(collectionDepartement)
          .doc(department)
          .update({"title": FieldValue.delete()});
      await db
          .collection(hotelCollection)
          .doc(hotelName)
          .collection(collectionDepartement)
          .doc(department)
          .update({"title": FieldValue.arrayUnion(titleList)});
    }
    if (newTitle != null) {
      await db
          .collection(hotelCollection)
          .doc(hotelName)
          .collection(collectionDepartement)
          .doc(department)
          .update({
        "title": FieldValue.arrayUnion([newTitle.toTitleCase()])
      });
    }
  }

  Future addLocation(String newLocation, String hotelName) async {
    await db.collection(hotelCollection).doc(hotelName).update({
      "location": FieldValue.arrayUnion([newLocation.toTitleCase()])
    });
  }

  Future deleteLocation(List<String> locations, String hotelName) async {
    await db
        .collection(hotelCollection)
        .doc(hotelName)
        .update({"location": FieldValue.delete()});
    await db
        .collection(hotelCollection)
        .doc(hotelName)
        .update({"location": FieldValue.arrayUnion(locations)});
  }
}
