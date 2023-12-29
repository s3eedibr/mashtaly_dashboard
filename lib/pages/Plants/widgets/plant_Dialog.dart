import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPlantDialog extends StatefulWidget {
  String? user_id, post_id;
  AddPlantDialog({super.key, required this.user_id, required this.post_id});

  @override
  State<AddPlantDialog> createState() => _AddPlantDialogState();
}

class _AddPlantDialogState extends State<AddPlantDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Plant Name'),
        ),
        SizedBox(height: 20),
        Text('Add 5 Pictures:'),
        // Here you can add widgets to add pictures (e.g., ImagePicker).
        // For simplicity, let's just use a placeholder for each picture.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            5,
            (index) => Container(
              width: 50,
              height: 50,
              color: Colors.grey, // Placeholder for the picture
            ),
          ),
        ),
      ],
    )));
  }
}
