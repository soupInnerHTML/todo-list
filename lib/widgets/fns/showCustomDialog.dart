import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Config {
  void Function()? callback;
  String text;

  Config({required this.callback, required this.text});
}

final dialogCallbackPerPlatform = Platform.isIOS ? showCupertinoDialog : showDialog;

showCustomDialog(BuildContext context, String title, String content,
    Config submitConfig, Config cancelConfig) {
  dialogCallbackPerPlatform<String>(
    context: context,
    builder: (BuildContext context) => Platform.isIOS ? CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: cancelConfig.callback,
          child: Text(
            cancelConfig.text,
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: submitConfig.callback,
          child: Text(
            submitConfig.text,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ) : AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: cancelConfig.callback,
          child: Text(
            cancelConfig.text,
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: submitConfig.callback,
          child: Text(
            submitConfig.text,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
