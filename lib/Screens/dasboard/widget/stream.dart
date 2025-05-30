import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../controller/c_user.dart';
import '../../../models/tasks.dart';

class StreamWidget {
  final cUser = Get.put(CUser());
  final taskmodel = Get.put(TaskModel());
  mine() {
    return FirebaseFirestore.instance
        .collection("Hotel List")
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .where("assigned", arrayContains: cUser.data.department)
        .where("status", isNotEqualTo: "Close")
        .snapshots(includeMetadataChanges: true);
  }

  other() {
    return FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotelid)
        .collection('tasks')
        .where("status", isNotEqualTo: "Close")
        .snapshots(includeMetadataChanges: true);
  }

  myPost() {
    return FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotelid)
        .collection("tasks")
        .where("from", isEqualTo: cUser.data.department)
        .orderBy('time', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  close() {
    return FirebaseFirestore.instance
        .collection('Hotel List')
        .doc(cUser.data.hotelid)
        .collection('tasks')
        .where("status", isEqualTo: "Close")
        .snapshots(includeMetadataChanges: true);
  }
}
