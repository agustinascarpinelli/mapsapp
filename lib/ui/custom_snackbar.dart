import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar(
      {required String text,
      String btnLabel = 'Ok',
      VoidCallback? onOk,
      Duration duration = const Duration(seconds: 3),
      Key? key})
      : super(
            key: key,
            content: Text(text),
            duration: duration,
            action: SnackBarAction(
                label: btnLabel,
                onPressed: () {
                  if (onOk != null) {
                    onOk();
                  }
                }));
}
