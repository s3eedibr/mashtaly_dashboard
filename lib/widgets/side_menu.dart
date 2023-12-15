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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 250.0),
                                  child: Text(
                                    'are you sure you want to logout?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )),
                              actions: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MaterialButton(
                                      height: 50.0,
                                      child: const Text(
                                        'yes',
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
                                    color: Colors.orange[800],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MaterialButton(
                                      height: 50.0,
                                      child: const Text(
                                        'no',
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

                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
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
