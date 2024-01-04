import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  const CustomText(
      {Key? key, required this.text, this.size, this.color, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? tPrimaryTextColor,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
