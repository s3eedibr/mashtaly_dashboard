import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/Constants/colors.dart';

class DetailsPlantDialog extends StatefulWidget {
  final String? plant_ID;
  DetailsPlantDialog({super.key, this.plant_ID});

  @override
  State<DetailsPlantDialog> createState() => _DetailsPlantDialogState();
}

class _DetailsPlantDialogState extends State<DetailsPlantDialog> {
  @override
  Widget build(BuildContext context) {
    String? plantID = widget.plant_ID;
    CollectionReference dataFromFire =
        FirebaseFirestore.instance.collection('plants');

    return FutureBuilder<QuerySnapshot>(
        future: dataFromFire.where('id', isEqualTo: plantID).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: tPrimaryActionColor,
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Document does not exist"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.docs[0].data() as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data['plant_pic'],
                            width: 600,
                            height: 300,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Image.asset(
                                'assets/images/default_plant.jpg',
                                width: 108,
                                height: 108,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    data['plantName'],
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            );
          }
          return Text("loading");
        });
  }
}
