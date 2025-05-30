import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
import 'package:post_app/common_widget/dialog_role.dart';
import 'package:post_app/common_widget/form_create_account.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key, required this.departement});
  final String departement;

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<AdminController>(context, listen: false);
    final theme = Theme.of(context);
    final user = Get.put(CUser());
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: fullWidth < maxWidth ? 30.sp : 30,
          leading: InkWell(
            borderRadius: BorderRadius.circular(50.r),
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.only(left: fullWidth < maxWidth ? 15.sp : 15),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: fullWidth < maxWidth ? 25.sp : 25,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: theme.focusColor,
                  )),
            ),
          ),
          backgroundColor: theme.cardColor,
          title: Text(
            "Create Account",
            style: TextStyle(
                color: theme.focusColor,
                fontSize: fullWidth < maxWidth ? 20.sp : 20),
          ),
        ),
        body: Consumer2<AdminController, HomeController>(
            builder: (context, value, value2, child) {
          String? domainEmail = value2.dataHotel!.domain;
          var color = value.userColor..shuffle();
          int index = Random().nextInt(value.userColor.length);
          return ListView(
            padding: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
            children: [
              FormCreateAcount(
                enterButtonAction: TextInputAction.next,
                label: 'Employee Name',
                textContronller: value.nameText,
              ),
              SizedBox(
                height: fullWidth < maxWidth ? 10.sp : 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormCreateAcount(
                      enterButtonAction: TextInputAction.next,
                      label: 'Create email',
                      textContronller: value.emailText,
                    ),
                  ),
                  SizedBox(
                    width: fullWidth < maxWidth ? 5.w : 5,
                  ),
                  Container(
                    width: fullWidth < maxWidth ? 170.w : 170,
                    padding: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
                    alignment: Alignment.centerLeft,
                    height: fullWidth < maxWidth ? 50.h : 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            fullWidth < maxWidth ? 13.r : 13),
                        border: Border.all(
                            color: theme.focusColor.withOpacity(0.3))),
                    child: Text(
                      domainEmail!,
                      style: TextStyle(
                          fontSize: fullWidth < maxWidth ? 16.sp : 16,
                          color: theme.focusColor.withOpacity(0.3)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: fullWidth < maxWidth ? 10.sp : 10,
              ),
              FormCreateAcount(
                enterButtonAction: TextInputAction.next,
                label: 'Password',
                textContronller: value.passwordText,
              ),
              SizedBox(
                height: fullWidth < maxWidth ? 10.sp : 10,
              ),
              Column(
                children: [
                  SizedBox(
                    height: fullWidth < maxWidth ? 10.sp : 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Select role of user:",
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 14.sp : 14,
                            color: theme.focusColor.withOpacity(0.3)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: fullWidth < maxWidth ? 5.sp : 5,
                  ),
                  InkWell(
                    borderRadius:
                        BorderRadius.circular(fullWidth < maxWidth ? 13.r : 13),
                    onTap: () => showRoleDialog(
                      context: context,
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
                      alignment: Alignment.centerLeft,
                      height: fullWidth < maxWidth ? 50.h : 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              fullWidth < maxWidth ? 13.r : 13),
                          border: Border.all(
                              color: theme.focusColor.withOpacity(0.3))),
                      child: Text(
                        value.roleSelected,
                        style: TextStyle(
                            fontSize: fullWidth < maxWidth ? 16.sp : 16,
                            color: theme.focusColor.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: fullWidth < maxWidth ? 20.sp : 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: fullWidth < maxWidth ? 35.h : 35,
                      width: double.infinity,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: theme.focusColor.withOpacity(0.3)),
                            foregroundColor: theme.focusColor,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: fullWidth < maxWidth ? 30.h : 30,
                    ),
                    SizedBox(
                      height: fullWidth < maxWidth ? 35.h : 35,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          onPressed: () async {
                            String domainEmail = value2.dataHotel!.domain!;
                            // print("password nyaa ${value.passwordText.text}");
                            // print("nama nyaa ${value.nameText.text}");
                            // print("emal nya ${value.emailText.text}");
                            // print("warna nya $color[index]");
                            print("domain nya ${user.data.hotel}");
                            await event.createAccount(
                                context: context,
                                role: value.roleSelected,
                                hotel: user.data.hotel!,
                                colorsUser: color[index],
                                domainEmail: domainEmail,
                                dept: departement);
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
