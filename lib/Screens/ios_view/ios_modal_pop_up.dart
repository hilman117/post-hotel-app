import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/core.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../global_function.dart';
import '../../models/departement_model.dart';

void showAssignModalSheet(
    BuildContext context, TaskModel task, ScrollController scrol) {
  final provider = Provider.of<ChatRoomController>(context, listen: false);
  final theme = Theme.of(context);
  TextEditingController search = TextEditingController();
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  final app = AppLocalizations.of(context);
  showCupertinoModalPopup(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Column(
          children: [
            Text(app!.assignedThisTaskToAnotherUserOrGroup,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            Text(
              app.byAssignThisTaskToUserOrGroupThatBeingChoosenThisTaskAutomaticallyWillAppearOnTheirDashboard,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12.sp),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
                height: 30.h,
                child: CupertinoSearchTextField(
                  controller: search,
                  onChanged: (value) => provider.searchFuntion(value),
                )),
          ],
        ),
        message: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      app.group,
                      style: TextStyle(
                          letterSpacing: 0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: fullWidth < maxWidth ? 16.sp : 16),
                    ),
                  ),
                  Consumer<ChatRoomController>(
                      builder: (context, value, child) {
                    return Column(
                      children:
                          List.generate(value.departments.length, (index) {
                        Departement dept = value.departments[index];
                        if (dept.departement.toString().toLowerCase().contains(
                                value.textInput.toString().toLowerCase()) ||
                            value.textInput.isEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dept.departement!,
                                style: TextStyle(
                                    letterSpacing: 0,
                                    color: theme.focusColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize:
                                        fullWidth < maxWidth ? 14.sp : 14),
                              ),
                              Checkbox(
                                splashRadius: 0,
                                value: value.boolLlistGroup![index],
                                onChanged: (value) {
                                  Provider.of<ChatRoomController>(context,
                                          listen: false)
                                      .selectFucntionGroup(value!, index);
                                },
                              )
                            ],
                          );
                        }
                        return Container();
                      }),
                    );
                  }),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "User",
                      style: TextStyle(
                          letterSpacing: -0.5,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: fullWidth < maxWidth ? 16.sp : 16),
                    ),
                  ),
                  Consumer<ChatRoomController>(
                      builder: (context, value, child) {
                    return Column(
                      children: List.generate(value.users.length, (index) {
                        UserDetails name = value.users[index];
                        if (name.name!
                            .toLowerCase()
                            .contains(value.textInput.toLowerCase())) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name.name!,
                                style: TextStyle(
                                    letterSpacing: 0,
                                    color: theme.focusColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize:
                                        fullWidth < maxWidth ? 14.sp : 14),
                              ),
                              Checkbox(
                                splashRadius: 0,
                                value: value.boolLlistemployee![index],
                                onChanged: (value) {
                                  Provider.of<ChatRoomController>(context,
                                          listen: false)
                                      .selectFucntionEmployee(value!, index);
                                },
                              )
                            ],
                          );
                        }
                        return Container();
                      }),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child:
                Consumer<ChatRoomController>(builder: (context, value, child) {
              return Text(
                app.assign,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: value.departmentsAndNamesSelected.isEmpty
                      ? CupertinoColors.inactiveGray
                      : CupertinoColors.activeBlue,
                ),
              );
            }),
            onPressed: () {
              final controller = context.read<ChatRoomController>();
              if (controller.departmentsAndNamesSelected.isNotEmpty) {
                if (Provider.of<GlobalFunction>(context, listen: false)
                        .hasInternetConnection ==
                    true) {
                  provider.assign(context, task, scrol);
                  FocusScope.of(context).unfocus();
                } else {
                  Provider.of<GlobalFunction>(context, listen: false)
                      .noInternet(app.noInternetPleaseCheckYourConnection);
                }
                Navigator.pop(context, 'Assign');
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          child: Text(
            app.cancel,
            style: TextStyle(fontSize: 16.sp),
          ),
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
      );
    },
  );
}
