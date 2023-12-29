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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Plant Name'),
            ),
          ],
        ),
      ),
    );
  }
}

  // Widget _buildPlantImage() {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         onTap: () {
  //           selectImageDialog(context);
  //         },
  //         child: Container(
  //           height: 200,
  //           width: 379.4,
  //           clipBehavior: Clip.antiAlias,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(6),
  //             ),
  //           ),
  //           child: _image != null
  //               ? Image.file(
  //                   _image!,
  //                   fit: BoxFit.cover,
  //                 )
  //               : const Icon(
  //                   FontAwesomeIcons.plus,
  //                   color: tSearchIconColor,
  //                   size: 55,
  //                 ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
