import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/helpers/local_navigator.dart';
import 'package:mashtaly_dashboard/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SideMenu()),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: localNavigator(),
          ),
        )
      ],
    );
  }
}
