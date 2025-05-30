import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/homescreen/home.dart';
import '../Screens/sign_in/signin.dart';
import '../fireabase_service/firebase_auth.dart';
import '../models/user.dart';
import 'session_user.dart';

class AuthenticationWrapper extends StatefulWidget {
  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  late Future<bool> _authCheckFuture;

  @override
  void initState() {
    super.initState();
    _authCheckFuture = _checkAuthAndSession();
  }

  Future<bool> _checkAuthAndSession() async {
    bool loggedIn = await FirebaseAuthService.isLoggedIn();
    UserDetails? session = await SessionsUser.getUser();
    return loggedIn && session != null;
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final isDarkTheme = currentTheme.brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
        statusBarColor: currentTheme.scaffoldBackgroundColor,
        systemNavigationBarColor: currentTheme.scaffoldBackgroundColor,
      ),
    );

    return FutureBuilder<bool>(
      future: _authCheckFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // Tampilkan loading selama proses pengecekan login
          return Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Image.asset("images/error.png")),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return const HomeScreen();
        } else {
          return const SignIn();
        }
      },
    );
  }
}
