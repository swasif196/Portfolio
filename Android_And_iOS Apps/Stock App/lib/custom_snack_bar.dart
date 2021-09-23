import 'package:flutter/material.dart';

void showInfoSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1, milliseconds: 500),
      )
  );
}

void showErrorSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
            message,
            style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
        ),
        duration: Duration(seconds: 1, milliseconds: 500),
      )
  );
}