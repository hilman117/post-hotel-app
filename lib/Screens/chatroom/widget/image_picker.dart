// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:post_app/service/theme.dart';
import 'package:provider/provider.dart';

Future imagePickerBottomSheet(
    {required BuildContext context,
    required double height,
    required double widht,
    void Function()? todoIfHasImage}) {
  double fullWidth = MediaQuery.of(context).size.width;
  double maxWidth = 500;
  final app = AppLocalizations.of(context);
  return showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(fullWidth < maxWidth ? 16.r : 16),
              topRight: Radius.circular(fullWidth < maxWidth ? 16.r : 16))),
      context: context,
      builder: (context) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(fullWidth < maxWidth ? 16.r : 16),
                  topRight: const Radius.circular(16)),
            ),
            height: fullWidth < maxWidth ? 200.h : 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonPickImage(
                  fullWidth: fullWidth,
                  maxWidth: maxWidth,
                  buttonName: app!.camera,
                  iconButton: Icons.camera_front_outlined,
                  event: () async {
                    await Provider.of<ChatRoomController>(context,
                            listen: false)
                        .selectFromCamera(context);
                    if (todoIfHasImage != null) {
                      todoIfHasImage();
                    }
                    Navigator.pop(context);
                  },
                ),
                ButtonPickImage(
                  fullWidth: fullWidth,
                  maxWidth: maxWidth,
                  buttonName: app.fromGalery,
                  iconButton: Icons.image_outlined,
                  event: () async {
                    await Provider.of<ChatRoomController>(context,
                            listen: false)
                        .selectImage(context, ImageSource.gallery);
                    if (todoIfHasImage != null) {
                      todoIfHasImage();
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ));
}

class ButtonPickImage extends StatelessWidget {
  const ButtonPickImage({
    super.key,
    required this.fullWidth,
    required this.maxWidth,
    required this.buttonName,
    required this.iconButton,
    required this.event,
  });

  final double fullWidth;
  final double maxWidth;
  final String buttonName;
  final IconData iconButton;
  final void Function() event;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: fullWidth < maxWidth ? 20.sp : 20),
      width: double.infinity,
      height: fullWidth < maxWidth ? 55.h : 55,
      child: OutlinedButton.icon(
        icon: Icon(iconButton,
            color: mainColor, size: fullWidth < maxWidth ? 20.sp : 20),
        label: Text(
          buttonName,
          style: TextStyle(
              color: mainColor, fontSize: fullWidth < maxWidth ? 14.sp : 14),
        ),
        style: OutlinedButton.styleFrom(
            foregroundColor: mainColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(fullWidth < maxWidth ? 10.sp : 10))),
        onPressed: event,
      ),
    );
  }
}
