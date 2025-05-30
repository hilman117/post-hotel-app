import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/sign_in/sign_in_controller.dart';
import 'package:post_app/custom/custom_scroll_behavior.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController emailC = TextEditingController();
  late TextEditingController passwordC = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    final theme = Theme.of(context);
    final controller = Provider.of<SignInController>(context, listen: false);
    final bilingual = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/post-logo-fix.png",
                    height: 120.h,
                    width: 120.w,
                  ),
                  Text(
                    "POST",
                    style: TextStyle(
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.bold,
                        fontSize: fullWidth < maxWidth ? 23.sp : 23,
                        color: theme.focusColor),
                  ),
                  SizedBox(
                    height: fullWidth < maxWidth ? 7.h : 7,
                  ),
                  Text(
                    bilingual!.hotelInternalMessagingSystem,
                    style: TextStyle(
                        letterSpacing: 0,
                        fontSize: fullWidth < maxWidth ? 16.sp : 16,
                        color: theme.focusColor),
                  ),
                  SizedBox(
                    height: fullWidth < maxWidth ? 20.h : 20,
                  ),
                  Form(
                    key: _keyForm,
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          SizedBox(
                              height: fullWidth < maxWidth ? 45.h : 45,
                              child: TextFormField(
                                autofillHints: const [AutofillHints.email],
                                textInputAction: TextInputAction.next,
                                controller: emailC,
                                cursorColor: mainColor,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: fullWidth < maxWidth ? 20.sp : 20,
                                    color: theme.focusColor),
                                cursorHeight: 20.h,
                                decoration: InputDecoration(
                                  hintText: bilingual.email,
                                  hintStyle: TextStyle(
                                      fontSize:
                                          fullWidth < maxWidth ? 20.sp : 20,
                                      color: CupertinoColors.inactiveGray),
                                ),
                              )),
                          SizedBox(
                            height: fullWidth < maxWidth ? 12.h : 12,
                          ),
                          SizedBox(
                              height: fullWidth < maxWidth ? 45.h : 45,
                              child: TextFormField(
                                autofillHints: const [AutofillHints.password],
                                textInputAction: TextInputAction.done,
                                controller: passwordC,
                                cursorColor: mainColor,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: fullWidth < maxWidth ? 20.sp : 20,
                                    color: theme.focusColor),
                                cursorHeight: 20.h,
                                decoration: InputDecoration(
                                  hintText: bilingual.password,
                                  hintStyle: TextStyle(
                                      fontSize:
                                          fullWidth < maxWidth ? 20.sp : 20,
                                      color: CupertinoColors.inactiveGray),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: fullWidth < maxWidth ? 12.h : 12,
                  ),
                  SizedBox(
                    height: fullWidth < maxWidth ? 35.h : 35,
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      color: mainColor,
                      child: Text(
                        bilingual.login,
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 20.sp : 20,
                            color: Colors.white),
                      ),
                      onPressed: () => controller.signIn(
                          context, emailC.text, passwordC.text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final Uri url = Uri.parse('https://post-apps.com');

  void _launchURL() async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Tidak dapat membuka URL: $url';
    }
  }
}
