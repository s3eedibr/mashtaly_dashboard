import 'package:flutter/material.dart';

import '../constants/colors.dart';

void showSnakBar(BuildContext context, String message,
    {Color color = tThirdTextErrorColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: tBgColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      backgroundColor: color,
    ),
  );
}
