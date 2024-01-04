import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
// import 'package:mashtaly_dashboard/pages/overview/widgets/overview_cards.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

import 'widgets/statistics.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Obx(
          () => Row(
            children: [
              Container(
                child: CustomText(
                  text: menuController.activeItem.value,
                  size: 25,
                  weight: FontWeight.bold,
                  color: tPrimaryActionColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              PostStatistics(),
            ],
          ),
        ),
      ],
    );
  }
}
