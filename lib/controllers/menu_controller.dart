import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        return _customIcon(FontAwesomeIcons.chartColumn, itemName);
      case plantPageDisplayName:
        return _customIcon(FontAwesomeIcons.leaf, itemName);
      case accountsPageDisplayName:
        return _customIcon(FontAwesomeIcons.users, itemName);
      case authenticationPageDisplayName:
        return _customIcon(FontAwesomeIcons.arrowRightFromBracket, itemName);
      case salePlantPageDisplayName:
        return _customIcon(FontAwesomeIcons.dollar, itemName);
      case postPlantPageDisplayName:
        return _customIcon(FontAwesomeIcons.newspaper, itemName);
      case ReportingPageDisplayName:
        return _customIcon(FontAwesomeIcons.triangleExclamation, itemName);

      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(icon, size: 25, color: tThirdTextColor);
    }

    return Icon(
      icon,
      color: tPrimaryActionColor,
    );
  }
}
