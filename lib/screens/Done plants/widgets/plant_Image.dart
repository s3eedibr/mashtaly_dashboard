import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../Constants/colors.dart';

Widget buildPlantImage(
  BuildContext context,
  image,
  Function() pickImageFromGallery,
  Function() captureImageFromCamera,
) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          selectImageDialog(
              context, pickImageFromGallery, captureImageFromCamera);
        },
        child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Container(
              height: 450,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: image != null
                  ? Image.file(
                      File(image.path),
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      FontAwesomeIcons.plus,
                      color: tSearchIconColor,
                      size: 55,
                    ),
            )),
      ),
    ],
  );
}

Future<dynamic> selectImageDialog(BuildContext context,
    Function() pickImageFromGallery, Function() captureImageFromCamera) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          dialogBackgroundColor: Colors.white,
        ),
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: const Text(
            "Select Image from",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: tPrimaryTextColor,
            ),
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      captureImageFromCamera();
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Text(
                          "Camera",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: tPrimaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      pickImageFromGallery();
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.image),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: tPrimaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
