import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/change_password/change_password_controller.dart';
import 'package:post_app/common_widget/form_create_account.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

import '../homescreen/home_controller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final eventHome = Provider.of<HomeController>(context, listen: false);
    final theme = Theme.of(context);
    final user = Get.put(CUser());
    final controller =
        Provider.of<ChangePasswordController>(context, listen: false);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Change Password"),
        previousPageTitle: "Back",
      ),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            children: [
              SizedBox(
                height: 30.h,
              ),
              Consumer<ChangePasswordController>(
                builder: (context, value, child) => FormCreateAcount(
                  label: "Current Password",
                  textContronller: value.currentPassword,
                  isPasswordForm: true,
                  enterButtonAction: TextInputAction.next,
                  typingFunction: (text) =>
                      controller.checkCurrentPassword(text),
                ),
              ),
              Consumer<ChangePasswordController>(
                  builder: (context, value, child) {
                if (value.currentPass != user.data.password &&
                    value.currentPass.isNotEmpty) {
                  return Text(
                    "Current password doesn't macthed",
                    style: TextStyle(color: Colors.red, fontSize: 13.sp),
                  );
                }
                return SizedBox(
                  height: 12.sp,
                );
              }),
              SizedBox(
                height: 16.h,
              ),
              Consumer<ChangePasswordController>(
                builder: (context, value, child) => FormCreateAcount(
                  label: "New Password",
                  textContronller: value.newPassword,
                  isPasswordForm: true,
                  enterButtonAction: TextInputAction.next,
                  typingFunction: (text) => controller.checkNewPassword(text),
                ),
              ),
              Consumer<ChangePasswordController>(
                  builder: (context, value, child) {
                if (value.newPass == value.currentPass &&
                    value.newPass.isNotEmpty) {
                  return Text(
                    "this is current password",
                    style: TextStyle(color: Colors.red, fontSize: 13.sp),
                  );
                }
                return SizedBox(
                  height: 12.sp,
                );
              }),
              SizedBox(
                height: 16.h,
              ),
              Consumer<ChangePasswordController>(
                builder: (context, value, child) => FormCreateAcount(
                  label: "Confirm New Password",
                  textContronller: value.confirmPassword,
                  isPasswordForm: true,
                  enterButtonAction: TextInputAction.done,
                  typingFunction: (text) => controller.checkConPassword(text),
                ),
              ),
              Consumer<ChangePasswordController>(
                  builder: (context, value, child) {
                if (value.newPass != value.conPass &&
                    value.conPass.isNotEmpty) {
                  return Text(
                    "Confirm password doesn't macthed",
                    style: TextStyle(color: Colors.red, fontSize: 13.sp),
                  );
                }
                return SizedBox(
                  height: 12.sp,
                );
              }),
              SizedBox(
                height: 16.h,
              ),
              Consumer<ChangePasswordController>(
                  builder: (context, value, child) => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              elevation:
                                  ThemeMode.system == ThemeMode.dark ? 0 : 1),
                          onPressed: (value.newPass == value.conPass &&
                                  value.currentPass != value.newPass &&
                                  value.currentPass.isNotEmpty &&
                                  value.newPass.isNotEmpty &&
                                  value.conPass.isNotEmpty)
                              ? () => controller.changePassword(context)
                              : null,
                          child: Text(
                            "Update Password",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ))))
            ],
          ),
        ),
      ),
    );
    // WillPopScope(
    //   onWillPop: () async {
    //     Navigator.of(context).popUntil((route) => route.isFirst);
    //     eventHome.selectScreens(0);
    //     return true;
    //   },
    //   child: GestureDetector(
    //     onHorizontalDragEnd: (details) {
    //       if (details.primaryVelocity! > 0) {
    //         eventHome.selectScreens(0);
    //         Get.back();
    //       }
    //     },
    //     child: Scaffold(
    //       appBar: AppBar(
    //         backgroundColor: theme.scaffoldBackgroundColor,
    //         elevation: 0,
    //         title: Text(
    //           "Change Password",
    //           style: TextStyle(color: theme.focusColor, fontSize: 20.sp),
    //         ),
    //         centerTitle: false,
    //       ),
    //       body:
    //     ),
    //   ),
    // );
  }
}

// import 'package:flutter/cupertino.dart';

// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});

//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }

// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   final TextEditingController currentPasswordController =
//       TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   bool isLoading = false;

//   void handleChangePassword() {
//     final current = currentPasswordController.text.trim();
//     final newPassword = newPasswordController.text.trim();
//     final confirm = confirmPasswordController.text.trim();

//     if (current.isEmpty || newPassword.isEmpty || confirm.isEmpty) {
//       showCupertinoDialog(
//         context: context,
//         builder: (_) => const CupertinoAlertDialog(
//           title: Text("Error"),
//           content: Text("Please fill in all fields."),
//           actions: [
//             CupertinoDialogAction(isDefaultAction: true, child: Text("OK")),
//           ],
//         ),
//       );
//       return;
//     }

//     if (newPassword != confirm) {
//       showCupertinoDialog(
//         context: context,
//         builder: (_) => const CupertinoAlertDialog(
//           title: Text("Mismatch"),
//           content: Text("New passwords do not match."),
//           actions: [
//             CupertinoDialogAction(isDefaultAction: true, child: Text("OK")),
//           ],
//         ),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     // Simulate a delay for password change
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() => isLoading = false);
//       showCupertinoDialog(
//         context: context,
//         builder: (_) => const CupertinoAlertDialog(
//           title: Text("Success"),
//           content: Text("Your password has been updated."),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text("Change Password"),
//         previousPageTitle: "Back",
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
//           child: Column(
//             children: [
//               CupertinoTextField(
//                 controller: currentPasswordController,
//                 placeholder: 'Current Password',
//                 obscureText: true,
//                 padding: const EdgeInsets.all(12),
//               ),
//               const SizedBox(height: 16),
//               CupertinoTextField(
//                 controller: newPasswordController,
//                 placeholder: 'New Password',
//                 obscureText: true,
//                 padding: const EdgeInsets.all(12),
//               ),
//               const SizedBox(height: 16),
//               CupertinoTextField(
//                 controller: confirmPasswordController,
//                 placeholder: 'Confirm New Password',
//                 obscureText: true,
//                 padding: const EdgeInsets.all(12),
//               ),
//               const SizedBox(height: 32),
//               CupertinoButton.filled(
//                 onPressed: isLoading ? null : handleChangePassword,
//                 child: isLoading
//                     ? const CupertinoActivityIndicator()
//                     : const Text("Update Password"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
