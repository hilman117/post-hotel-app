import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/chatroom/widget/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:post_app/l10n/app_localizations.dart';
import '../../../../../../../service/theme.dart';
import '../../../../../../homescreen/widget/card_request.dart';
import '../../../../../chatroom_controller.dart';

class TextFieldArea extends StatelessWidget {
  const TextFieldArea({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Expanded(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.r)),
        elevation: isDark ? 0 : 1.sp,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius:
                  BorderRadius.circular(fullWidth < maxWidth ? 13.r : 13)),
          height: fullWidth < maxWidth ? 35.h : 50,
          child: TextFormField(
            cursorColor: mainColor,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: fullWidth < maxWidth ? 14.sp : 14,
            onChanged: (value) {
              Provider.of<ChatRoomController>(context, listen: false)
                  .typing(value);
            },
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 1,
            maxLines: 5,
            style: TextStyle(
                fontSize: fullWidth < maxWidth ? 14.sp : 14,
                overflow: TextOverflow.clip,
                color: theme.focusColor),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: AppLocalizations.of(context)!.typeHere,
              hintStyle: TextStyle(
                  fontSize: fullWidth < maxWidth ? 14.sp : 14,
                  color: ThemeMode.system == ThemeMode.light
                      ? theme.shadowColor
                      : Colors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              prefixIcon: IconButton(
                onPressed: () {
                  imagePickerBottomSheet(
                      context: context, height: height, widht: width);
                },
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: theme.primaryColor,
                  size: fullWidth < maxWidth ? 20.sp : 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
