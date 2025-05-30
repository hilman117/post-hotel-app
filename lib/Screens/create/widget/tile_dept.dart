import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TileDept extends StatelessWidget {
  final String departement;
  final VoidCallback callback;
  const TileDept(
      {super.key, required this.departement, required this.callback});

  @override
  Widget build(BuildContext context) {
    double widht = Get.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: callback,
        child: Container(
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
          height: 35,
          child: Row(
            children: [
              Image.asset("images/$departement.png", width: widht * 0.06),
              SizedBox(
                width: widht * 0.04,
              ),
              Text(
                departement,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
