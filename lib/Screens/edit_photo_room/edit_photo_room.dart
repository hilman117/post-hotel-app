// Dart imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:post_app/l10n/app_localizations.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import 'widget/example_helper.dart';

/// A widget that provides a default example of a stateful widget.
///
/// The [EditPhotoRoom] widget is a simple stateful widget that serves as
/// a basic example or template for creating a new widget with state management.
/// It can be used as a starting point when building more complex widgets.
///
/// The state for this widget is managed by the [_EditPhotoRoom] class.
///
/// Example usage:
/// ```dart
/// EditPhotoRoom();
/// ```
class EditPhotoRoom extends StatefulWidget {
  final Uint8List imageToEdit;

  /// Creates a new [EditPhotoRoom] widget.
  const EditPhotoRoom({super.key, required this.imageToEdit});

  @override
  State<EditPhotoRoom> createState() => _EditPhotoRoomState();
}

/// The state for the [EditPhotoRoom] widget.
///
/// This class manages the behavior and state of the [EditPhotoRoom] widget.
class _EditPhotoRoomState extends State<EditPhotoRoom>
    with ExampleHelperState<EditPhotoRoom> {
  late final _configs = ProImageEditorConfigs(
    designMode: platformDesignMode,
  );
  late final _callbacks = ProImageEditorCallbacks(
    onImageEditingStarted: onImageEditingStarted,
    onImageEditingComplete: onImageEditingComplete,
    onCloseEditor: (editorMode) => onCloseEditor(editorMode: editorMode),
    mainEditorCallbacks: MainEditorCallbacks(
      helperLines: HelperLinesCallbacks(onLineHit: vibrateLineHit),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.black,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: SizedBox(
          height: Get.height,
          width: double.infinity,
          child: _buildMemoryEditor(context, widget.imageToEdit)),
    );
  }

  Widget _buildMemoryEditor(BuildContext context, Uint8List bytes) {
    final bilingual = AppLocalizations.of(context);
    return ProImageEditor.memory(
      bytes,
      callbacks: _callbacks,
      configs: _configs.copyWith(
          i18n: I18n(
        cancel: bilingual!.cancel,
        done: bilingual.done,
        doneLoadingMsg: bilingual.changesAreBeingApplied,
        redo: bilingual.redo,
        remove: bilingual.remove,
        undo: bilingual.undo,
      )),
    );
  }
}
