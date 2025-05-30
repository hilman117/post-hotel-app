
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/homescreen/home_controller.dart';
import 'package:provider/provider.dart';
import '../../../ios_view/ios_sorting_task_bottom_sheet.dart';

Widget customAppbar(BuildContext context) {
  final event = Provider.of<HomeController>(context, listen: false);
  final theme = Theme.of(context);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  return SliverAppBar(
      shadowColor: Colors.grey,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: fullWidth < maxWidth ? 15.w : 15),
          child: InkWell(
            borderRadius: BorderRadius.circular(50.r),
            // onTap: () => showSettingCupertinoModal(context),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(CupertinoIcons.settings),
            ),
          ),
        )
      ],
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.scaffoldBackgroundColor,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: theme.scaffoldBackgroundColor,
      // ),
      title:
          CupertinoSearchTextField(style: TextStyle(color: theme.focusColor)),
      elevation: ThemeMode.system == ThemeMode.light ? 1 : 0,
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: fullWidth < maxWidth ? 75.h : 75,
      flexibleSpace: Container(
        height: double.maxFinite,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(fullWidth < maxWidth ? 50.h : 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                ),
                height: fullWidth < maxWidth ? 50.h : 50,
                child:
                    Consumer<HomeController>(builder: (context, value, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: fullWidth < maxWidth ? 20.sp : 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              value.sortByMine,
                              style: TextStyle(
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.bold,
                                  color: theme.focusColor,
                                  fontSize: fullWidth < maxWidth ? 25.sp : 25),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Text(
                              value.sortByClose,
                              style: TextStyle(
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: fullWidth < maxWidth ? 18.sp : 18),
                            ),
                          ],
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () => showSortingTaskCupertinoModal(context),
                          child: CircleAvatar(
                            radius: fullWidth < maxWidth ? 14.sp : 14,
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(
                              CupertinoIcons.sort_down,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })),
          )));
}

Widget filterStatus(BuildContext ctx, String label, bool isSelected) {
  double fullWidth = MediaQuery.of(ctx).size.width;
  double maxWidth = 500;
  final theme = Theme.of(ctx);
  return Container(
    width: isSelected ? 80.w : 70.w,
    height: fullWidth < maxWidth ? 30.h : 30,
    alignment: Alignment.center,
    margin: EdgeInsets.only(
        left: isSelected ? 1.0.sp : 0.sp,
        right: isSelected ? 1.0.sp : 0.sp,
        top: 1.sp,
        bottom: 1.sp),
    decoration: BoxDecoration(
      color: isSelected ? theme.primaryColor : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(fullWidth < maxWidth ? 10.r : 10),
    ),
    child: Text(
      label,
      style: TextStyle(
          fontSize: fullWidth < maxWidth ? 14.sp : 14,
          color: isSelected ? Colors.white : theme.primaryColor),
    ),
  );
}
