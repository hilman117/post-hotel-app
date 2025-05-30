import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:post_app/Screens/homescreen/widget/pages/admin/admin_controller.dart';
import 'package:post_app/models/departement_model.dart';
import 'package:provider/provider.dart';

Future showAllDepartement({required BuildContext context}) {
  final theme = Theme.of(context);
  final event = Provider.of<AdminController>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            content: Consumer<HomeController>(builder: (context, value, child) {
              return LimitedBox(
                child: Container(
                  width: 300.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      color: theme.cardColor),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        List.generate(value.listDepartement!.length, (index) {
                      Departement departement = value.listDepartement![index];
                      return InkWell(
                        onTap: () => event.selectDepartement(
                            context, departement.departement!),
                        child: Material(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8.0.sp),
                            child: Row(
                              children: [
                                Image.asset(
                                  departement.departementIcon!,
                                  width: 25.w,
                                  height: 25.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  departement.departement!,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: theme.focusColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
          ));
}
