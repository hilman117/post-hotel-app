import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageRoom extends StatefulWidget {
  const ImageRoom({super.key, required this.image, required this.id});
  final List<dynamic> image;
  final String id;

  @override
  State<ImageRoom> createState() => _ImageRoomState();
}

class _ImageRoomState extends State<ImageRoom> {
  void saveNetworkImage(String url) async {
    print("----------------------");
    print("save network image");
    final temDir = await getTemporaryDirectory();
    final path = '${temDir.path}/myfile.jpg';
    // await Dio().download(url, path);
    final respon = await http.get(Uri.parse(url));
    final bytes = respon.bodyBytes;
    File(path).writeAsBytesSync(bytes);
    // var result = await GallerySaver.saveImage(path, albumName: "POST");
    // print("Hasil: $result");
    // if (result == true) {
    //   Fluttertoast.showToast(
    //       msg: "Image Saved",
    //       textColor: Colors.green.shade900,
    //       backgroundColor: Colors.white);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Failed to download",
    //       textColor: Colors.red.shade900,
    //       backgroundColor: Colors.white);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // InkWell(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Center(
            //         child: Hero(
            //             tag: "imageHero",
            //             child: SizedBox(
            //                 width: Get.width,
            //                 height: Get.height * 0.7,
            //                 child: Image.network(widget.image))))),
            // SizedBox(
            //   height: 20,
            // ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10)),
            //         backgroundColor: Colors.orange),
            //     onPressed: () {
            //       _saveNetworkImage(widget.image);
            //     },
            //     child: Icon(Icons.download))
          ],
        ),
      ),
    );
  }
}
