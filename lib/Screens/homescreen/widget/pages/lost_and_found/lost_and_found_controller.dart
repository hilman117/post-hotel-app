import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/common_widget/loading.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/core.dart';
import 'package:post_app/fireabase_service/firebase_read_data.dart';

class LostAndFoundControntroller with ChangeNotifier {
  final read = FirebaseReadData();
  final user = Get.put(CUser());

  List<TaskModel> listLostAndFound = [];

  Future<void> readLostAndFound(BuildContext context) async {
    loading(context);
    listLostAndFound = await read.getLostAndFountByName().then((value) =>
        value.docs.map((e) => TaskModel.fromJson(e.data())).toList());

    Navigator.of(context).pop();
    print(listLostAndFound);
    notifyListeners();
  }
}
