import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/screens/Done%20accounts/Accounts.dart';
import 'package:mashtaly_dashboard/screens/Done%20plants/plants.dart';
import 'package:mashtaly_dashboard/screens/Done%20overview/overview.dart';
import 'package:mashtaly_dashboard/screens/Done%20reports/reports.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';

import '../screens/Done articles/articles.dart';
import '../screens/Done salePlant/salePlants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case plantsPageRoute:
      return _getPageRoute(const PlantsPage());
    case accountsPageRoute:
      return _getPageRoute(const AccountsPage());
    case ReportingPageRoute:
      return _getPageRoute(const ReportingPage());
    case salePlantPageRoute:
      return _getPageRoute(const SalePlantsPage());
    case postPlantPageRoute:
      return _getPageRoute(const PostPage());
    default:
      return _getPageRoute(Container());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
