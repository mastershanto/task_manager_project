import 'package:flutter/material.dart';

void showSnackMessage(BuildContext context,String message, bool bool,
    {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : null,
    ),
  );
}
