import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_app/Screens/settings/setting_provider.dart';
import 'package:provider/provider.dart';

class PhotoProfile extends StatelessWidget {
  final String urlImage;
  final double lebar;
  final double tinggi;
  final double radius;
  const PhotoProfile(
      {super.key,
      required this.lebar,
      required this.tinggi,
      required this.radius,
      required this.urlImage});

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double maxWidth = 500;
    return Consumer<SettingProvider>(
        builder: (context, value, child) => ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: urlImage != ''
                  ? LayoutBuilder(
                      builder: (p0, p1) => Image.network(
                            urlImage,
                            fit: BoxFit.cover,
                            width: p1.maxWidth * 1,
                            height: p1.maxHeight * 1,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Container(
                                    width: p1.maxWidth * 1,
                                    height: p1.maxHeight * 1,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.other_houses_rounded,
                                      size: fullWidth < maxWidth ? 100.sp : 100,
                                    ));
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              // ignore: avoid_print
                              print("ini error nya $error");
                              return Icon(Icons.other_houses_rounded,
                                  size: fullWidth < maxWidth ? 100.sp : 100);
                            },
                          ))
                  : LayoutBuilder(builder: (p0, p1) {
                      return Icon(Icons.other_houses_rounded,
                          size: fullWidth < maxWidth ? 100.sp : 100);
                    }),
            ));
  }
}
