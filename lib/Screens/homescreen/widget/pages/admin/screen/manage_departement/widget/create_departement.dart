import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
import 'package:post_app/common_widget/form_create_account.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:provider/provider.dart';

class CreateDepartement extends StatelessWidget {
  const CreateDepartement({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final event = Provider.of<AdminController>(context, listen: false);
    final user = Get.put(CUser());
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: fullWidth < maxWidth ? 30.w : 30,
        leading: InkWell(
          borderRadius: BorderRadius.circular(fullWidth < maxWidth ? 50.r : 50),
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: fullWidth < maxWidth ? 15.sp : 15),
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: fullWidth < maxWidth ? 25.sp : 25,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: theme.focusColor,
                  size: fullWidth < maxWidth ? 20.sp : 20,
                )),
          ),
        ),
        backgroundColor: theme.cardColor,
        title: Text(
          "Create Departement",
          style: TextStyle(
              color: theme.focusColor,
              fontSize: fullWidth < maxWidth ? 20.sp : 20),
        ),
      ),
      body: SizedBox(
        // height: 200.h,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: fullWidth < maxWidth ? 20.h : 20,
            ),
            Consumer<AdminController>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: FormCreateAcount(
                    typingFunction: (value) => event.input(deptName: value),
                    label: "Name Departement",
                    textContronller: value.inputNameDepartement),
              ),
            ),
            SizedBox(
              height: fullWidth < maxWidth ? 10.h : 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: fullWidth < maxWidth ? 10.sp : 10),
              child: Text(
                "Select Icon",
                style: TextStyle(
                    fontSize: fullWidth < maxWidth ? 13.sp : 13,
                    color: theme.focusColor),
              ),
            ),
            SizedBox(
              height: fullWidth < maxWidth ? 10.h : 10,
            ),
            Consumer<AdminController>(
              builder: (context, value, child) => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: fullWidth < maxWidth ? 10.sp : 10),
                  padding: EdgeInsets.all(fullWidth < maxWidth ? 10.sp : 10),
                  width: fullWidth < maxWidth ? 200.w : 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          fullWidth < maxWidth ? 13.r : 13),
                      color: theme.cardColor),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: fullWidth < maxWidth ? 10.sp : 10,
                    spacing: fullWidth < maxWidth ? 10.sp : 10,
                    children: List.generate(
                        value.departementIcon.length,
                        (index) => InkWell(
                              onTap: () => event.selecIcon(
                                  context, value.departementIcon[index]),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: value.selectedIcon ==
                                                value.departementIcon[index]
                                            ? theme.focusColor
                                            : Colors.transparent)),
                                alignment: Alignment.center,
                                height: fullWidth < maxWidth ? 35.h : 35,
                                width: fullWidth < maxWidth ? 35.w : 35,
                                child: Image.asset(
                                  value.departementIcon[index],
                                  height: fullWidth < maxWidth ? 30.h : 30,
                                  width: fullWidth < maxWidth ? 30.w : 30,
                                ),
                              ),
                            )),
                  )),
            ),
            SizedBox(
              height: fullWidth < maxWidth ? 10.h : 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: fullWidth < maxWidth ? 10.sp : 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.grey),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: theme.primaryColor),
                    ))),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: fullWidth < maxWidth ? 10.sp : 10),
                child: Consumer<AdminController>(
                  builder: (context, value, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: value.newDept.isEmpty
                              ? Colors.grey
                              : theme.primaryColor),
                      onPressed: () {
                        var color = value.userColor..shuffle();
                        int index = Random().nextInt(value.userColor.length);
                        event.createDepartement(
                            context, user.data.hotel!, color[index]);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: value.newDept.isEmpty
                                ? theme.primaryColor
                                : Colors.white),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
