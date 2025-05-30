// Dart imports:
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_app/Screens/create/create_request_controller.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:provider/provider.dart';

/// A page that displays a preview of the generated image.
///
/// The [PreviewImgPage] widget is a stateful widget that shows a preview of
/// an image created using the provided [imgBytes]. It also supports showing
/// a thumbnail of the original image if [showThumbnail] is set to true.
///
/// The page can display additional information such as [generationTime], the
/// original raw image as [rawOriginalImage], and optional [generationConfigs]
/// used during the image creation process.
///
/// If [showThumbnail] is set to true, [rawOriginalImage] must be provided.
///
/// Example usage:
/// ```dart
/// PreviewImgPage(
///   imgBytes: generatedImageBytes,
///   generationTime: 1200,
///   rawOriginalImage: originalImage,
///   showThumbnail: true,
/// );
/// ```
class PreviewImgPage extends StatefulWidget {
  /// Creates a new [PreviewImgPage] widget.
  ///
  /// The [imgBytes] parameter is required and contains the generated image
  /// data to be displayed. The [generationTime] is optional and represents
  /// the time taken to generate the image. If [showThumbnail] is true,
  /// [rawOriginalImage] must be provided.
  const PreviewImgPage({
    super.key,
    required this.imgBytes,
    this.generationTime,
    this.rawOriginalImage,
    this.generationConfigs,
    this.showThumbnail = false,
  }) : assert(
          showThumbnail == false || rawOriginalImage != null,
          'rawOriginalImage is required if you want to display a thumbnail.',
        );

  /// The image data in bytes to be displayed.
  final Uint8List imgBytes;

  /// The time taken to generate the image, in milliseconds.
  final double? generationTime;

  /// Whether or not to show a thumbnail of the original image.
  final bool showThumbnail;

  /// The original raw image, required if [showThumbnail] is true.
  final ui.Image? rawOriginalImage;

  /// Optional configurations used during image generation.
  final ImageGenerationConfigs? generationConfigs;

  @override
  State<PreviewImgPage> createState() => _PreviewImgPageState();
}

/// The state for the [PreviewImgPage] widget.
///
/// This class manages the logic and display of the preview image and optional
/// thumbnail, along with any associated generation information.
class _PreviewImgPageState extends State<PreviewImgPage> {
  @override
  Widget build(BuildContext context) {
    final bilingual = AppLocalizations.of(context);
    final controller =
        Provider.of<CreateRequestController>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black,
            statusBarColor: Colors.black,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Hero(
          tag: const ProImageEditorConfigs().heroTag,
          child: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: double.infinity,
                child: Center(
                  child: Image.memory(
                    widget.imgBytes,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20.h,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: Text(
                      bilingual!.done,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => controller.addToSelectedImageList(
                        context, widget.imgBytes),
                  ))
            ],
          ),
        ));
  }
}
