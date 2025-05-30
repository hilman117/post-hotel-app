import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_app/Screens/chatroom/chatroom_controller.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void iosImagePicker(BuildContext context, bool isCreateNewTask) async {
  final bilingual = AppLocalizations.of(context);
  final eventCreate =
      Provider.of<CreateRequestController>(context, listen: false);
  final eventChat = Provider.of<ChatRoomController>(context, listen: false);
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                if (isCreateNewTask) {
                  eventCreate.selectFromCamera(context);
                  Navigator.pop(context);
                } else {
                  eventChat.selectFromCamera(context);
                  Navigator.pop(context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bilingual!.camera,
                    style: TextStyle(
                        fontSize: 18.sp, color: CupertinoColors.activeBlue),
                  ),
                  const Icon(CupertinoIcons.camera_fill,
                      color: CupertinoColors.activeBlue)
                ],
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                if (isCreateNewTask) {
                  eventCreate.selectImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                } else {
                  eventChat.selectImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bilingual.fromGalery,
                    style: TextStyle(
                        fontSize: 18.sp, color: CupertinoColors.activeBlue),
                  ),
                  const Icon(CupertinoIcons.photo_fill_on_rectangle_fill,
                      color: CupertinoColors.activeBlue)
                ],
              )),
        ],
      );
    },
  );
}
