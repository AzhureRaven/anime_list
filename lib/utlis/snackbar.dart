import 'package:flutter/material.dart';

SnackBar basicSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 5),
  );
}