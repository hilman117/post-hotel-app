import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:post_app/Screens/sign_in/signin.dart';

import '../homescreen/home.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('user is not signed in yet');
            return const SignIn();
          } else if (userSnapshot.hasData) {
            print('user is already signed in');
            return const HomeScreen();
          } else if (userSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Image.asset("images/error.png"),
              ),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
          return Scaffold(
            body: Center(
              child: Image.asset("images/error.png"),
            ),
          );
        });
  }
}
