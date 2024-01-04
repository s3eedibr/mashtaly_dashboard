import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';
import 'package:mashtaly_dashboard/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          SizedBox(
            height: 12,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () async {
                      if (item.route == authenticationPageRoute) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 250.0),
                                  child: Text(
                                    'Are you sure to logout?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  )),
                              actions: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: tPrimaryActionColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MaterialButton(
                                      height: 50.0,
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.offAllNamed(
                                            authenticationPageRoute);
                                        await FirebaseAuth.instance.signOut();
                                      }),
                                ),
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: tThirdTextErrorColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MaterialButton(
                                      height: 50.0,
                                      child: const Text(
                                        'No',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            );
                          },
                        );

                        menuController.changeActiveItemTo("");
                        navigationController.navigateTo("");
                      } else if (!menuController.isActive(item.name)) {
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
