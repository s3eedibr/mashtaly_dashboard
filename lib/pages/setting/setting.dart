import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
                color: tPrimaryActionColor,
              )),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: const [],
        )),
      ],
    );
  }
}
