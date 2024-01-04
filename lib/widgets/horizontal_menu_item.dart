import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:get/get.dart';
import 'package:mashtaly_dashboard/constants/style.dart';

import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const HorizontalMenuItem({Key? key, required this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Obx(
        () => Container(
          child: Row(
            children: [
              SizedBox(width: width / 87),
              if (!menuController.isActive(itemName))
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: menuController.returnIconFor(itemName),
                    ),
                    CustomText(
                      text: itemName,
                      color: lightGrey,
                    ),
                  ],
                )
              else
                SizedBox(
                  width: width / 7,
                  child: Container(
                    decoration: BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: menuController.returnIconFor(itemName),
                        ),
                        CustomText(
                          text: itemName,
                          color: tThirdTextColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
