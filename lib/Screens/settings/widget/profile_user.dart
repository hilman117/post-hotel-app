import 'package:flutter/material.dart';
import 'package:post_app/Screens/settings/setting_provider.dart';
import 'package:post_app/common_widget/photo_profile.dart';
import 'package:provider/provider.dart';
import '../../homescreen/widget/card_request.dart';
import 'image_picker_profile.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<SettingProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () => imagePickerProfile(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                PhotoProfile(
                  lebar: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? size.width * 0.08
                      : size.width * 0.15,
                  tinggi: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? size.height * 0.14
                      : size.height * 0.08,
                  radius: 30,
                  urlImage: value.imageUrl,
                ),
                Positioned(
                    left: width * 0.087,
                    top: height * 0.05,
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 10,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black45,
                        size: 15,
                      ),
                    ))
              ],
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cUser.data.name!,
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
                SizedBox(
                  height: height * 0.005,
                ),
                Text(
                  cUser.data.position!,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
