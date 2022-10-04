import 'package:flutter/material.dart';

import '../colors/colors.dart';

snackBar(String? message, context, {Color? color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      elevation: 0,
      content: Text(
        message!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: AppColors.white),
      ),
      duration: Duration(milliseconds: 3000),
    ),
  );
}
