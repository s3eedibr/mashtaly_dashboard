import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case plantPageDisplayName:
        return _customIcon(Icons.energy_savings_leaf, itemName);
      case accountsPageDisplayName:
        return _customIcon(Icons.person, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      case ReportingPageDisplayName:
        return _customIcon(Icons.report, itemName);

      case sellPlantPageDisplayName:
        return _customIcon(Icons.monetization_on, itemName);
      case postPlantPageDisplayName:
        return _customIcon(Icons.post_add, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(icon, size: 22, color: tThirdTextColor);
    }

    return Icon(
      icon,
      color: tPrimaryActionColor,
    );
  }
}
