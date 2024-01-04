import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/screens/Done%20salePlant/widgets/salePlants_table.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class SalePlantsPage extends StatelessWidget {
  const SalePlantsPage({Key? key}) : super(key: key);

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
                size: 24,
                weight: FontWeight.bold,
                color: tPrimaryActionColor,
              )),
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
            SalePlantsTableScreen()
          ],
        )),
      ],
    );
  }
}