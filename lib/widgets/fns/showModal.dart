import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/CustomForm.dart';

showModal(context, action, callback, [initialValue]) =>
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return Container(
          height: 200,
          margin: EdgeInsets.only(bottom: bottom),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomForm(
                  action: action,
                  callback: callback,
                  initialValue: initialValue,
                ),
              ],
            ),
          ),
        );
      },
    );
