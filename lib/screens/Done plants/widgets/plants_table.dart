import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mashtaly_dashboard/screens/Done%20plants/widgets/details_plant_Dialog.dart';

import '../../../constants/colors.dart';

class PlantsTableScreen extends StatefulWidget {
  @override
  _PlantsTableState createState() => _PlantsTableState();
}

List<Map<String, dynamic>>? plantData;

class _PlantsTableState extends State<PlantsTableScreen> {
  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      // padding: const EdgeInsets.all(16),
      // margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
          height: 550,
          child: plantData == null
              ? const Center(child: CircularProgressIndicator())
              : DataTable2(
                  columnSpacing: 15,
                  dataRowHeight: 65,
                  headingRowHeight: 40,
                  horizontalMargin: 10,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text(
                        'ID',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      size: ColumnSize.L,
                      fixedWidth: 65,
                    ),
                    DataColumn(
                      label: Text(
                        'Plant name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      size: ColumnSize.S,
                      fixedWidth: 75,
                    ),
                  ],
                  rows: plantData!
                      .map(
                        (plant) => DataRow(
                          cells: [
                            DataCell(Text('${plant['id']}')),
                            DataCell(Text('${plant['plantName']}')),
                            DataCell(InkWell(
                              onTap: () {},
                              child: IconButton(
                                  icon: const Text(
                                    'Details',
                                    style: TextStyle(
                                      color: tPrimaryActionColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            constraints: const BoxConstraints(
                                              maxWidth: 850,
                                              minWidth: 850,
                                              minHeight: 800,
                                            ),
                                            child: DetailsPlantDialog(
                                              plant_ID: plant['id'],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0), // Adjust the radius as needed
                                                    ),
                                                    color: tPrimaryActionColor,
                                                    height: 50.0,
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          200.0),
                                                              child: Text(
                                                                'Are you sure you want to delete ${plant['plantName']}?',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                            actions: [
                                                              Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      tPrimaryActionColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    MaterialButton(
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            const Text(
                                                                          'Yes',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await deletePlantInFirebase(
                                                                            plant['id'],
                                                                          );
                                                                          await fetchDataFromFirebase();
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ),
                                                              Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      tThirdTextErrorColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    MaterialButton(
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            const Text(
                                                                          'No',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0), // Adjust the radius as needed
                                                    ),
                                                    color: tPrimaryActionColor,
                                                    height: 50.0,
                                                    child: const Text(
                                                      'Activate',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            actionsAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            content: Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          200.0),
                                                              child: Text(
                                                                'Are you sure you want to activate ${plant['plantName']}?',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            actions: [
                                                              Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      tPrimaryActionColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    MaterialButton(
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            const Text(
                                                                          'Yes',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await activatePlantInFirebase(
                                                                            plant['id'],
                                                                          );
                                                                          await fetchDataFromFirebase();
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ),
                                                              Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      tThirdTextErrorColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    MaterialButton(
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            const Text(
                                                                          'No',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                                const SizedBox(
                                                  width: 20.0,
                                                ),
                                                MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0), // Adjust the radius as needed
                                                    ),
                                                    color: tThirdTextErrorColor,
                                                    height: 50.0,
                                                    child: const Text(
                                                      'Deactivate',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          200.0),
                                                              child: Text(
                                                                'Are you sure you want to deactivate ${plant['plantName']}?',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                            actions: [
                                                              Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      tPrimaryActionColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    MaterialButton(
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            const Text(
                                                                          'Yes',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await deactivatePlantInFirebase(
                                                                            plant['id'],
                                                                          );
                                                                          await fetchDataFromFirebase();
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ),
                                                              Container(
                                                                width: 150,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      tThirdTextErrorColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    MaterialButton(
                                                                        height:
                                                                            50.0,
                                                                        child:
                                                                            const Text(
                                                                          'No',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            )),
                          ],
                        ),
                      )
                      .toList(),
                )),
    );
  }

  Future<void> activatePlantInFirebase(String plantId) async {
    try {
      // Update 'active' field in the plant with the specified plant_id
      QuerySnapshot plantsSnapshot = await FirebaseFirestore.instance
          .collection('plants')
          .where('id', isEqualTo: plantId)
          .get();

      for (QueryDocumentSnapshot plantDoc in plantsSnapshot.docs) {
        await plantDoc.reference.update({'active': true});
      }

      print('Updated successfully');
    } catch (e) {
      print('Error activating plant: $e');
    }
  }

  Future<void> deactivatePlantInFirebase(String plantId) async {
    try {
      // Update 'active' field in the plant with the specified plant_id
      QuerySnapshot plantsSnapshot = await FirebaseFirestore.instance
          .collection('plants')
          .where('id', isEqualTo: plantId)
          .get();

      for (QueryDocumentSnapshot plantDoc in plantsSnapshot.docs) {
        await plantDoc.reference.update({'active': false});
      }

      print('Updated successfully');
    } catch (e) {
      print('Error activating plant: $e');
    }
  }

  Future<void> deletePlantInFirebase(String plantId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Get a reference to the collection
      CollectionReference collectionReference = firestore.collection('plants');

      // Query for documents with the specified plantId
      QuerySnapshot<Object?> querySnapshot =
          await collectionReference.where('id', isEqualTo: plantId).get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Loop through the matching documents and delete each one
        for (QueryDocumentSnapshot<Object?> documentSnapshot
            in querySnapshot.docs) {
          DocumentReference documentReference =
              collectionReference.doc(documentSnapshot.id);

          // Delete the document
          await documentReference.delete();

          print('Document deleted successfully');
        }
      } else {
        print('No documents found with the specified plantId');
      }
    } catch (error) {
      print('Error deleting document: $error');
    }
  }
}
