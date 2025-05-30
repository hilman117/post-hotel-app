import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/core.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:provider/provider.dart';

import '../../global_function.dart';
import '../../l10n/app_localizations.dart';

class IosAssignPage extends StatefulWidget {
  const IosAssignPage({super.key, required this.task, required this.scrol});

  final TaskModel task;
  final ScrollController scrol;

  @override
  State<IosAssignPage> createState() => _IosAssignPageState();
}

class _IosAssignPageState extends State<IosAssignPage> {
  bool isFocus = false;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isFocus = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final app = AppLocalizations.of(context);
    final event = Provider.of<ChatRoomController>(context, listen: false);
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
          backgroundColor: theme.cardColor,
          middle: Text(
            "Assign",
            style: TextStyle(color: theme.focusColor),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                event.clearListAssign();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: theme.primaryColor,
              )),
          trailing:
              Consumer<ChatRoomController>(builder: (context, value, child) {
            return CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: value.departmentsAndNamesSelected.isEmpty
                  ? null
                  : () {
                      if (Provider.of<GlobalFunction>(context, listen: false)
                              .hasInternetConnection ==
                          true) {
                        event.assign(context, widget.task, widget.scrol);
                      } else {
                        Provider.of<GlobalFunction>(context, listen: false)
                            .noInternet(
                                app!.noInternetPleaseCheckYourConnection);
                      }
                      Navigator.of(context).pop();
                    },
              child: value.isLoading
                  ? Transform.scale(
                      scale: 0.5,
                      child:
                          const CircularProgressIndicator(color: Colors.blue),
                    )
                  : Text(
                      "Done",
                      style: TextStyle(
                          letterSpacing: -0.5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: value.departmentsAndNamesSelected.isEmpty
                              ? CupertinoColors.inactiveGray
                              : theme.primaryColor),
                    ),
            );
          })),
      child: Material(
        color: theme.cardColor,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: fullWidth < maxWidth ? 15.sp : 15),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  CupertinoSearchTextField(
                    autofocus: isFocus,
                    controller: search,
                    onChanged: (value) {
                      event.searchFuntion(value);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0.sp, top: 18.sp, bottom: 8.0.sp),
                    child: Text(
                      "Group",
                      style: TextStyle(
                          letterSpacing: 0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: fullWidth < maxWidth ? 12.sp : 12),
                    ),
                  ),
                  Consumer<ChatRoomController>(
                      builder: (context, value, child) {
                    return Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp),
                          color: theme.scaffoldBackgroundColor),
                      child: Column(
                        children:
                            List.generate(value.departments.length, (index) {
                          Departement dept = value.departments[index];
                          if (dept.departement
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.textInput
                                      .toString()
                                      .toLowerCase()) ||
                              value.textInput.isEmpty) {
                            return ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  dept.departement!,
                                  style: TextStyle(
                                      letterSpacing: 0,
                                      color: theme.focusColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          fullWidth < maxWidth ? 16.sp : 16),
                                ),
                                trailing: Switch.adaptive(
                                  activeColor: theme.primaryColor,
                                  inactiveThumbColor: theme.primaryColor,
                                  activeTrackColor: Colors.green,
                                  inactiveTrackColor:
                                      CupertinoColors.inactiveGray,
                                  onChanged: (value) {
                                    Provider.of<ChatRoomController>(context,
                                            listen: false)
                                        .selectFucntionGroup(value, index);
                                  },
                                  value: value.boolLlistGroup![index],
                                ));
                          }
                          return Container();
                        }),
                      ),
                    );
                  }),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8.0.sp, top: 18.sp, bottom: 8.0.sp),
                child: Text(
                  "User",
                  style: TextStyle(
                      letterSpacing: -0.5,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: fullWidth < maxWidth ? 12.sp : 12),
                ),
              ),
              Consumer<ChatRoomController>(builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.sp),
                      color: theme.scaffoldBackgroundColor),
                  child: Column(
                    children: List.generate(value.users.length, (index) {
                      UserDetails name = value.users[index];
                      if (name.name!
                          .toLowerCase()
                          .contains(value.textInput.toLowerCase())) {
                        return ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              name.name!,
                              style: TextStyle(
                                  letterSpacing: -0.5,
                                  color: theme.focusColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: fullWidth < maxWidth ? 16.sp : 16),
                            ),
                            subtitle: Text(
                              name.email!,
                              style: TextStyle(
                                  letterSpacing: 0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: fullWidth < maxWidth ? 13.sp : 13),
                            ),
                            trailing: Switch.adaptive(
                              activeColor: theme.primaryColor,
                              inactiveThumbColor: theme.primaryColor,
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: CupertinoColors.inactiveGray,
                              onChanged: (value) {
                                Provider.of<ChatRoomController>(context,
                                        listen: false)
                                    .selectFucntionEmployee(value, index);
                              },
                              value: value.boolLlistemployee![index],
                            ));
                      }
                      return Container();
                    }),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
