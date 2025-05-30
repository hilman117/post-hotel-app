import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

loading(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black54,
    context: context,
    builder: (context) => Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    ),
  );
}
