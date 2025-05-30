// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Screens/create/create_request_controller.dart';

showDepartmentCupertinoModal(BuildContext context) {
  final theme = Theme.of(context);
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  final event = Provider.of<CreateRequestController>(context, listen: false);
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(CupertinoPageRoute(
                //   builder: (context) {
                //     return const IosCreatePage(isTask: true);
                //   },
                // ));
              },
              child: const Text("Create Task")),
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(CupertinoPageRoute(
                //   builder: (context) {
                //     return const IosCreatePage(isTask: false);
                //   },
                // ));
              },
              child: const Text("Lost and Found")),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            // Tindakan yang akan dijalankan ketika tombol Batal dipilih
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      );
      // Consumer<HomeController>(builder: (context, value, child) {
      //   List<Departement> listActiveDept = value.listDepartement
      //       .where((element) => element.isActive == true)
      //       .toList();
      //   return CupertinoActionSheet(
      //     title: Text(
      //       "Choose Department",
      //       style: TextStyle(
      //           letterSpacing: 0,
      //           fontWeight: FontWeight.bold,
      //           color: theme.focusColor,
      //           fontSize: fullWidth < maxWidth ? 15.sp : 15),
      //     ),
      //     actions: List.generate(
      //         listActiveDept.length,
      //         (index) => CupertinoActionSheetAction(
      //               child: Row(
      //                 children: [
      //                   Image.asset(
      //                     listActiveDept[index].departementIcon!,
      //                     width: fullWidth < maxWidth ? 25.w : 25,
      //                     height: fullWidth < maxWidth ? 25.h : 25,
      //                   ),
      //                   SizedBox(
      //                     width: fullWidth < maxWidth ? 10.w : 10,
      //                   ),
      //                   Text(
      //                     listActiveDept[index].departement!,
      //                     style: TextStyle(
      //                         letterSpacing: 0,
      //                         fontWeight: FontWeight.w500,
      //                         color: theme.focusColor,
      //                         fontSize: fullWidth < maxWidth ? 15.sp : 15),
      //                   )
      //                 ],
      //               ),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //                 Navigator.of(context)
      //                     .push(CupertinoPageRoute(builder: (context) {
      //                   event.selectDept(listActiveDept[index].departement!);
      //                   return IosCreatePage(
      //                     departement: listActiveDept[index],
      //                     isTask: true,
      //                   );
      //                 }));
      //               },
      //             )),
      //     cancelButton: CupertinoActionSheetAction(
      //       isDefaultAction: true,
      //       onPressed: () {
      //         // Tindakan yang akan dijalankan ketika tombol Batal dipilih
      //         Navigator.of(context).pop();
      //       },
      //       child: const Text('Close'),
      //     ),
      //   );
      // });
    },
  );
}

// Panggil fungsi ini ketika Anda ingin menampilkan bottom sheet
