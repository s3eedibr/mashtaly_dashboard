import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/pages/Plants/widgets/Plants_table.dart';
import 'package:mashtaly_dashboard/pages/Plants/widgets/plant_Dialog.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
                color: tPrimaryActionColor,
              )),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  // Show the dialog when the button is pressed
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 850,
                            minWidth: 850.0,
                            minHeight: 800,
                          ),
                          child: AddPlantDialog(
                            post_id: 'PqT5EHru7knzuzhubgLF',
                            user_id: 'JtfClvvgIPQBp7L6hqfEhD2jCvr1',
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Add logic to save plant information
                              // For now, just print the plant name to the console

                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Save'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      tPrimaryActionColor, // Set the background color here
                ),
                child: Text('Add Plant'),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: [PlantsTableScreen()],
        )),
      ],
    );
  }
}
