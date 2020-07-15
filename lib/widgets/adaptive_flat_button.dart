import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String label;
  final Function pressedHandler;
  final FocusNode focusNode;

  AdaptiveFlatButton(this.label, this.pressedHandler, this.focusNode);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: pressedHandler)
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: pressedHandler,
            focusNode: focusNode,
            child: Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
