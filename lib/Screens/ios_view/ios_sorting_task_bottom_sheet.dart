// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Screens/homescreen/home_controller.dart';

showSortingTaskCupertinoModal(BuildContext context) {
  final theme = Theme.of(context);
  final event = Provider.of<HomeController>(context, listen: false);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Consumer<HomeController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sort Task by:",
                style: TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                    color: theme.focusColor,
                    fontSize: fullWidth < maxWidth ? 15.sp : 15),
              ),
              SizedBox(height: fullWidth < maxWidth ? 20.sp : 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IosSortSwitch(
                      nameButton: "Mine",
                      currentValue: value.mineValue,
                      function: (value) => event.mineAll(value)),
                  IosSortSwitch(
                      nameButton: "Open",
                      currentValue: value.openValue,
                      function: (value) => event.openClose(context, value)),
                ],
              ),
            ],
          ),
        ),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            // Tindakan yang akan dijalankan ketika tombol Batal dipilih
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
      );
    },
  );
}

class IosSortSwitch extends StatelessWidget {
  const IosSortSwitch({
    super.key,
    required this.nameButton,
    required this.function,
    required this.currentValue,
  });

  final String nameButton;
  final bool currentValue;
  final void Function(bool) function;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: fullWidth < maxWidth ? 50.sp : 50,
          child: Text(
            nameButton,
            style: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                color: theme.focusColor,
                fontSize: fullWidth < maxWidth ? 15.sp : 15),
          ),
        ),
        SizedBox(width: fullWidth < maxWidth ? 15.sp : 15),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: currentValue,
            onChanged: function,
          ),
        ),
      ],
    );
  }
}

// Panggil fungsi ini ketika Anda ingin menampilkan bottom sheet
