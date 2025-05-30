import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
import 'package:provider/provider.dart';

Future dialogIconDept({required BuildContext context}) {
  final theme = Theme.of(context);
  final event = Provider.of<AdminController>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            content:
                Consumer<AdminController>(builder: (context, value, child) {
              return LimitedBox(
                child: Container(
                    padding: EdgeInsets.all(10.sp),
                    width: 200.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.r),
                        color: theme.cardColor),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 10.sp,
                      spacing: 10.sp,
                      children: List.generate(
                          value.departementIcon.length,
                          (index) => InkWell(
                                onTap: () => event.selecIcon(
                                    context, value.departementIcon[index]),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35.h,
                                  width: 35.w,
                                  child: Image.asset(
                                    value.departementIcon[index],
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                              )),
                    )),
              );
            }),
          ));
}
