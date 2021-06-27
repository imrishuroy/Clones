import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, this.title = 'Error', required this.content})
      : super(key: key);

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? _androidAlertDialog(context)
        : _cupertinoAlertDialog(context);
  }

  AlertDialog _androidAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        )
      ],
    );
  }

  CupertinoAlertDialog _cupertinoAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        )
      ],
    );
  }
}
