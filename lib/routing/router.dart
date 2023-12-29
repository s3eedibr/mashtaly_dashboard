import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/pages/Accounts/Accounts.dart';
import 'package:mashtaly_dashboard/pages/Plants/Plants.dart';
import 'package:mashtaly_dashboard/pages/SellPlant.dart/SellPlants.dart';
import 'package:mashtaly_dashboard/pages/overview/overview.dart';
import 'package:mashtaly_dashboard/pages/Reporting/Reporting.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';

import '../pages/Post.dart/Posts.dart';

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
    case sellPlantPageRoute:
      return _getPageRoute(const SellPlantsPage());
    case postPlantPageRoute:
      return _getPageRoute(const PostPage());
    default:
      return _getPageRoute(const OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
