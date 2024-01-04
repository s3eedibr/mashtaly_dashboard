import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';
import 'package:mashtaly_dashboard/constants/controllers.dart';
import 'package:mashtaly_dashboard/screens/Done%20plants/widgets/plants_table.dart';
import 'package:mashtaly_dashboard/screens/Done%20plants/widgets/add_plant_Dialog.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

int generateUniqueRandom5DigitsNumber() {
  DateTime now = DateTime.now().toUtc();
  int year = now.year;
  int month = now.month;
  int day = now.day;
  int hour = now.hour;
  int minute = now.minute;
  int second = now.second;

  int seed = year * 100000000 +
      month * 1000000 +
      day * 10000 +
      hour * 100 +
      minute * 10 +
      second;

  Random random = Random(seed);
  int uniqueRandomNumber = random.nextInt(90000) + 10000;

  return uniqueRandomNumber;
}

int random5digit = generateUniqueRandom5DigitsNumber();

class PlantsPage extends StatefulWidget {
  const PlantsPage({Key? key}) : super(key: key);

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref().child('Plants_Pic');
  Future<String> uploadImage(image) async {
    try {
      if (image != null) {
        try {
          String imagePath =
              'Plants_Pic/$random5digit/Plant$random5digit/plant_pic1';
          UploadTask uploadTask =
              storageRef.child(imagePath).putFile(File(image.path));
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          String imageUrl = await taskSnapshot.ref.getDownloadURL();

          return imageUrl;
        } catch (e) {
          print('Error adding photo to storage: $e');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return 'Error';
  }

  Future<void> addPlantToFirestore(
    image,
    plantNameController,
    amountOfWaterController,
  ) async {
    try {
      String imageUrl = await uploadImage(image);

      final plantData = {
        "id": '$random5digit',
        "plant_pic": imageUrl,
        "plantName": plantNameController.text.trim(),
        "amountOfWater": amountOfWaterController?.text?.trim(),
        "active": true,
        "date": '${DateTime.now()}',
      };
      setState(() {
        random5digit = generateUniqueRandom5DigitsNumber();
        fetchDataFromFirebase();
      });

      await firestore.collection('plants').doc().set(plantData);
    } catch (e) {
      print('Error adding plant: $e');
    }
  }

  CollectionReference plant = FirebaseFirestore.instance.collection('plants');
  Future<void> fetchDataFromFirebase() async {
    QuerySnapshot querySnapshot =
        await plant.orderBy('date', descending: true).get();
    setState(() {
      plantData = querySnapshot.docs
          .map((DocumentSnapshot document) =>
              document.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: CustomText(
                  text: menuController.activeItem.value,
                  size: 24,
                  weight: FontWeight.bold,
                  color: tPrimaryActionColor,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Show the dialog when the button is pressed
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        content: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 850,
                            minWidth: 850,
                            minHeight: 800,
                          ),
                          child: AddPlantDialog(),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              await addPlantToFirestore(image,
                                  plantNameController, amountOfWaterController);
                              image = null;
                              plantNameController.text = "";
                              amountOfWaterController.text = "";

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
                  backgroundColor: tPrimaryActionColor,
                ),
                child: Text(
                  'Add Plant',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              PlantsTableScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
