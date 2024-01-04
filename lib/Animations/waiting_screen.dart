import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/plant_loading2.gif",
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 16),
        const Text(
          'Loading...',
          style: TextStyle(
            color: tPrimaryTextColor,
            fontFamily: 'Mulish',
            decoration: TextDecoration.none,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
