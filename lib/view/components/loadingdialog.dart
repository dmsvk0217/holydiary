import 'package:flutter/material.dart';

class MyLoadingDialog {
  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20.0),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  static Future<void> hide(BuildContext context) async {
    Navigator.of(context).pop();
  }
}
