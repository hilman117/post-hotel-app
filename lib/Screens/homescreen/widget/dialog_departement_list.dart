import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/chatroom/widget/action_area/widget/keyboard/keyboard.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/Screens/ios_view/ios_create_page.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:provider/provider.dart';

Future showDepartementDialog(BuildContext context) {
  final theme = Theme.of(context);
  final event = Provider.of<CreateRequestController>(context, listen: false);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  final listDept = Provider.of<List<Departement>>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(vertical: 24.sp, horizontal: 60.sp),
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(fullWidth < maxWidth ? 13.r : 13)),
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            backgroundColor: theme.scaffoldBackgroundColor,
            content: Consumer<HomeController>(builder: (context, value, child) {
              List<Departement> allowedFamily = listDept
                  .where((element) => user.data.userGroup!
                      .any((group) => element.allowGroup!.contains(group)))
                  .toList();
              // print(allowedFamily);
              print(user.data.userGroup);
              return ContentDialog(
                  fullWidth: fullWidth,
                  maxWidth: maxWidth,
                  theme: theme,
                  listActiveDept: allowedFamily,
                  event: event);
            }),
          ));
}

class ContentDialog extends StatelessWidget {
  const ContentDialog({
    super.key,
    required this.fullWidth,
    required this.maxWidth,
    required this.theme,
    required this.listActiveDept,
    required this.event,
  });

  final double fullWidth;
  final double maxWidth;
  final ThemeData theme;
  final List<Departement> listActiveDept;
  final CreateRequestController event;

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return LimitedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(listActiveDept.length, (index) {
            Departement departement = listActiveDept[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).pop();
                event.clearSchedule();
                event.selectDept(departement.departement!);
                Get.to(
                    () =>
                        IosCreatePage(selectedDept: departement, isTask: true),
                    transition: Transition.rightToLeft);
              },
              highlightColor: Colors.grey.shade300,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  children: [
                    Image.network(
                      departement.departementIcon!,
                      width: fullWidth < maxWidth ? 25.w : 25,
                      height: fullWidth < maxWidth ? 25.h : 25,
                    ),
                    SizedBox(
                      width: fullWidth < maxWidth ? 10.w : 10,
                    ),
                    Text(
                      departement.departement!,
                      style: TextStyle(
                          fontSize: fullWidth < maxWidth ? 15.sp : 15,
                          color: theme.focusColor),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
