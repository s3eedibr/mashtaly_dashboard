import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/colors.dart';
import '../../../widgets/scan_plant_service.dart';
import 'plant_Image.dart';

class AddPlantDialog extends StatefulWidget {
  AddPlantDialog({
    super.key,
  });

  @override
  State<AddPlantDialog> createState() => _AddPlantDialogState();
}

final TextEditingController plantNameController = TextEditingController();
final TextEditingController amountOfWaterController = TextEditingController();
final ScanPlantService _scanPlantService = ScanPlantService();
XFile? image;

class _AddPlantDialogState extends State<AddPlantDialog> {
  Future<void> sendToApi() async {
    try {
      final imageFile = image;
      if (imageFile == null) {
        print('Error: Please select an image.');
        return;
      }

      plantName = null;
      final response = await _scanPlantService.sendImageToApi(imageFile);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Check if the expected data is present
        if (responseData.containsKey('results') &&
            responseData['results'] is List &&
            responseData['results'].isNotEmpty) {
          final species = responseData['results'][0]['species'];

          if (species != null &&
              species.containsKey('scientificNameWithoutAuthor') &&
              species['scientificNameWithoutAuthor'] != null) {
            setState(() {
              plantName = species['scientificNameWithoutAuthor'];
              commonName = species['commonNames'] != null &&
                      species['commonNames'].isNotEmpty
                  ? species['commonNames'][0]
                  : null;
            });
          } else {
            print('Error: Unexpected response format (missing species data).');
          }
        } else {
          print('Error: Unexpected response format (missing results data).');
        }
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
        sendToApi();
      });
    }
  }

  Future<void> captureImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
        sendToApi();
      });
    }
  }

  late String? plantName = '';
  late String? commonName = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            buildPlantImage(
              context,
              image,
              pickImageFromGallery,
              captureImageFromCamera,
            ),
            _buildPlantNameInput('Plant Name', TextInputType.text),
            _buildAmountOfWaterInput('Amount of Water', TextInputType.number),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantNameInput(String text, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 25),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Color(0x7C0D1904),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 750,
                child: TextFormField(
                  controller: plantNameController,
                  keyboardType: type,
                  cursorColor: tPrimaryActionColor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: plantName != null
                    ? () {
                        setState(() {
                          plantNameController.text = plantName!;
                        });
                      }
                    : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: tPrimaryActionColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    plantName != null
                        ? const Icon(
                            Icons.search_rounded,
                            size: 24,
                            color: Colors.white,
                          )
                        : const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountOfWaterInput(String text, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 0, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 25),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Color(0x7C0D1904),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextFormField(
              controller: amountOfWaterController,
              keyboardType: type,
              cursorColor: tPrimaryActionColor,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 15,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
