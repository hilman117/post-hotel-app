import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:post_app/global_function.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/service/auth_helper.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    final bilingual = AppLocalizations.of(context);
    Future.microtask(() => Provider.of<GlobalFunction>(context, listen: false)
        .checkInternetConnetction(
            bilingual!.noInternetPleaseCheckYourConnection));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: theme.scaffoldBackgroundColor,
            systemNavigationBarColor: theme.scaffoldBackgroundColor,
            systemNavigationBarIconBrightness:
                theme.brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light
            // Status bar brightness (optional)
            // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            // statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Consumer<GlobalFunction>(builder: (context, value, child) {
        if (value.isSplashShowed) {
          return const AuthenticationWrapper();
        }
        return Center(
            child:
                Lottie.asset("images/post-animated-logo.json", height: 150.h));
      }),
    );
  }
}
