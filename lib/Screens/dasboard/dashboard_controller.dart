import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  List<QueryDocumentSnapshot<Object?>> _list = [];
  List<QueryDocumentSnapshot<Object?>> get list => _list;
  int _lenght = 0;
  int get lenght => _lenght;
  void totalLenght(List<QueryDocumentSnapshot<Object?>> snapshot) {
    _list = snapshot;
  }

  void totalTask() {
    _lenght = _list.length;
    notifyListeners();
    // print(_lenght);
  }
}
