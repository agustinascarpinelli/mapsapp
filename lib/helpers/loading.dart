import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context, String content) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => AlertDialog(
              title: Text(content),
              content: Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,strokeWidth: 5,
                    ),
                  )),
            )));
            return;
  }

  showCupertinoDialog(
      context: context,
      builder: ((context) => CupertinoAlertDialog(
          title: Text(content),
          content: const CupertinoActivityIndicator(
            color: Colors.deepPurple,
          ))));
}
