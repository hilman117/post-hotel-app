
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GlobalMethod {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  static void showErrorDialog(
      {required String error, required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Something Wrong!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
                content: Center(
                  child: Text(
                    error,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // ignore: unnecessary_statements
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: const Text(
                      'OK!',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  
}
