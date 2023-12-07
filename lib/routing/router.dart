import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/pages/Accounts/Accounts.dart';
import 'package:mashtaly_dashboard/pages/Plants/Plants.dart';
import 'package:mashtaly_dashboard/pages/overview/overview.dart';
import 'package:mashtaly_dashboard/pages/setting/setting.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case plantsPageRoute:
      return _getPageRoute(const PlantsPage());
    case accountsPageRoute:
      return _getPageRoute(const AccountsPage());
    case settingPageRoute:
      return _getPageRoute(const SettingPage());
    case sellPlantPageRoute:
      return _getPageRoute(const SettingPage());
    default:
      return _getPageRoute(const OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
