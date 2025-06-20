import 'package:flutter/material.dart';

SnackBar customSnackBar(String message, bool isSuccess) {
  return SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: const EdgeInsets.all(16.0),
  );
}
