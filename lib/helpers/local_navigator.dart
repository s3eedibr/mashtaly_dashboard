import 'package:flutter/cupertino.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/routing/router.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: overviewPageRoute,
    );
