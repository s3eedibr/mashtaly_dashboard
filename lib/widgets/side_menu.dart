import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';
import 'package:mashtaly_dashboard/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: light,
      child: ListView(
        children: [
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () async {
                      if (item.route == authenticationPageRoute) {
                        Get.offAllNamed(authenticationPageRoute);
                        await FirebaseAuth.instance.signOut();

                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
                      }
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);

                        navigationController.navigateTo(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
