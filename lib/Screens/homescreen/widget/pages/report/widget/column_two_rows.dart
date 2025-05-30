import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../custom/custom_scroll_behavior.dart';

class ColumnTwoRows extends StatelessWidget {
  const ColumnTwoRows({
    super.key,
    required this.theme,
    required this.label,
    required this.data,
    required this.subLabel,
  });

  final ThemeData theme;
  final String label;
  final String subLabel;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      height: 400.h,
      decoration: BoxDecoration(border: Border.all(color: theme.focusColor)),
      child: Column(
        children: [
          //label
          Container(
            height: 40.h,
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: theme.focusColor.withOpacity(0.5)))),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.focusColor.withOpacity(0.5)),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                decoration: BoxDecoration(
                    border: Border(
                  right: BorderSide(color: theme.focusColor.withOpacity(0.5)),
                  bottom: BorderSide(color: theme.focusColor.withOpacity(0.5)),
                )),
                height: 35.h,
                width: 200.w,
                alignment: Alignment.center,
                child: Text(
                  subLabel.toUpperCase(),
                  style: TextStyle(
                      color: theme.focusColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom:
                        BorderSide(color: theme.focusColor.withOpacity(0.5)),
                  )),
                  height: 35.h,
                  alignment: Alignment.center,
                  child: Text(
                    "Jumlah".toUpperCase(),
                    style: TextStyle(
                        color: theme.focusColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    data.sort((a, b) => b["total"].compareTo(a["total"]));
                    if (data[index]["total"] != 0) {
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                  color: theme.focusColor.withOpacity(0.5)),
                              bottom: BorderSide(
                                  color: index == data.length - 1
                                      ? Colors.transparent
                                      : theme.focusColor.withOpacity(0.5)),
                            )),
                            height: 35.h,
                            width: 200.w,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data[index][subLabel],
                              style: TextStyle(
                                  color: theme.focusColor, fontSize: 14.sp),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.sp),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    color: index == data.length - 1
                                        ? Colors.transparent
                                        : theme.focusColor.withOpacity(0.5)),
                              )),
                              height: 35.h,
                              alignment: Alignment.center,
                              child: Text(
                                data[index]["total"].toString(),
                                style: TextStyle(
                                    color: theme.focusColor, fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
