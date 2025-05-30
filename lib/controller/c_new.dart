import 'package:get/get.dart';

class Cnew extends GetxController {
  final _data = false.obs;
  bool get data => _data.value;
  setData(n) => _data.value = n;
}
