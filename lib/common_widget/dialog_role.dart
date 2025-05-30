import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
import 'package:provider/provider.dart';

Future showRoleDialog({required BuildContext context}) {
  final theme = Theme.of(context);
  final event = Provider.of<AdminController>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            content:
                Consumer<AdminController>(builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.r),
                    color: theme.cardColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(value.role.length, (index) {
                    return InkWell(
                      onTap: () => event.selectRole(context, value.role[index]),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0.sp),
                        child: Text(
                          value.role[index],
                          style: TextStyle(
                              fontSize: 15.sp, color: theme.focusColor),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ));
}
