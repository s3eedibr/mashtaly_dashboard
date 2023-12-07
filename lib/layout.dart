import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/widgets/Homescreen.dart';
import 'package:mashtaly_dashboard/widgets/side_menu.dart';

import 'widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: const Drawer(
          child: SideMenu(),
        ),
        body: const HomeScreen());
  }
}
