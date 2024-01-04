import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mashtaly_dashboard/screens/Done%20salePlant/widgets/saleDialog.dart';

import '../../../getData/getData.dart';
import '../../../widgets/notification.dart';
import '../../Done articles/widgets/articles_dialog.dart';

class ReportingTableScreen extends StatefulWidget {
  @override
  _ReportingTableScreen createState() => _ReportingTableScreen();
}

class _ReportingTableScreen extends State<ReportingTableScreen> {
  List<Map<String, dynamic>>? plantData;
  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    await Future.delayed(Duration(seconds: 2));
    plantData = await getAllDataReport();
    setState(() {});
  }

  final reasonController = TextEditingController();
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
              ? Center(
                  child: CircularProgressIndicator(
                  color: tPrimaryActionColor,
                ))
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
                        'Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'User',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
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
                      size: ColumnSize.L,
                      fixedWidth: 75,
                    ),
                  ],
                  rows: plantData!
                      .map(
                        (post) => DataRow(
                          cells: [
                            DataCell(Text('${post['id']}')),
                            DataCell(Text('${post['title']}')),
                            DataCell(Text('${post['user']}')),
                            DataCell(DateParse(
                              firebaseDateString: '${post['date']}',
                            )),
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
                                            child: post['sale_pic1'] != null
                                                ? SaleDialogContent(
                                                    user_ID: post['user_id'],
                                                    post_id: post['id'],
                                                  )
                                                : PostDialogContent(
                                                    user_id: post['user_id'],
                                                    post_id: post['id'],
                                                  ),
                                          ),
                                          actions: [
                                            Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: tPrimaryActionColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: MaterialButton(
                                                  height: 50.0,
                                                  child: const Text(
                                                    'Ignore',
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
                                                                'Are you sure?',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20)),
                                                          ),
                                                          actions: [
                                                            _buildButton(
                                                              'Yes',
                                                              tPrimaryActionColor,
                                                              () async {
                                                                String userId =
                                                                    post[
                                                                        'user_id'];
                                                                String?
                                                                    fcmToken =
                                                                    await getFCMTokenForUser(
                                                                        userId);

                                                                if (fcmToken !=
                                                                    null) {
                                                                  post['sale_pic1'] !=
                                                                          null
                                                                      ? approveSellPlantInFirebase(
                                                                          post[
                                                                              'user_id'],
                                                                          post[
                                                                              'id'],
                                                                          false)
                                                                      : approvePostInFirebase(
                                                                          post[
                                                                              'user_id'],
                                                                          post[
                                                                              'id'],
                                                                          false);

                                                                  // await sendPushNotification(
                                                                  //   title:
                                                                  //       'Accept a post',
                                                                  //   body:
                                                                  //       'Your post has been accepted',
                                                                  //   token:
                                                                  //       fcmToken,
                                                                  //   context:
                                                                  //       context,
                                                                  // );
                                                                  fetchDataFromFirebase();
                                                                  //   addNotificationToFirestore(
                                                                  //       post[
                                                                  //           'user_id'],
                                                                  //       'Accept a post',
                                                                  //       'Sell Plant',
                                                                  //       'Your post has been accepted');
                                                                  //   Navigator.pop(
                                                                  //       context);
                                                                  // } else {
                                                                  //   print(
                                                                  //       'FCM Token not found for user with ID: $userId');
                                                                  //   // Handle the case where FCM token is not found (optional)
                                                                  // }
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                            ),
                                                            _buildButton('No',
                                                                tThirdTextErrorColor,
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 30.0,
                                            ),
                                            Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: tThirdTextErrorColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: MaterialButton(
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
                                                      // barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: TextField(
                                                            controller:
                                                                reasonController,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Reason for rejection',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            Row(
                                                              children: [
                                                                Center(
                                                                  child: _buildButton(
                                                                      'Ok',
                                                                      tPrimaryActionColor,
                                                                      () async {
                                                                    String
                                                                        userId =
                                                                        post[
                                                                            'user_id'];
                                                                    String?
                                                                        fcmToken =
                                                                        await getFCMTokenForUser(
                                                                            userId);

                                                                    if (fcmToken !=
                                                                        null) {
                                                                      post['sale_pic1'] !=
                                                                              null
                                                                          ? deleteSellPlantInFirebase(
                                                                              post['user_id'],
                                                                              post['id'],
                                                                            )
                                                                          : deletePostInFirebase(
                                                                              post['user_id'],
                                                                              post['id'],
                                                                            );

                                                                      await sendPushNotification(
                                                                        title:
                                                                            'Delete a post',
                                                                        body: reasonController.text !=
                                                                                ''
                                                                            ? reasonController.text.trim()
                                                                            : 'Your post has been deleted',
                                                                        token:
                                                                            fcmToken,
                                                                        context:
                                                                            context,
                                                                      );
                                                                      fetchDataFromFirebase();
                                                                      addNotificationToFirestore(
                                                                          post[
                                                                              'user_id'],
                                                                          'Delete a post',
                                                                          'Mashtaly Admin',
                                                                          reasonController.text != ''
                                                                              ? reasonController.text.trim()
                                                                              : 'Your post has been deleted');
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      print(
                                                                          'FCM Token not found for user with ID: $userId');
                                                                      // Handle the case where FCM token is not found (optional)
                                                                    }
                                                                  }),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Center(
                                                                  child: _buildButton(
                                                                      'Cancel',
                                                                      tThirdTextErrorColor,
                                                                      () async {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ),
                                            const SizedBox(
                                              width: 270,
                                            ),
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
}

class DateParse extends StatelessWidget {
  final String firebaseDateString;
  DateParse({super.key, required this.firebaseDateString});
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(firebaseDateString);
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(dateTime);
    return Text(formattedDate);
  }
}

Future<void> approvePostInFirebase(
    String userId, String documentId, bool newValue) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Get a reference to the collection
    CollectionReference collectionReference =
        firestore.collection('posts').doc(userId).collection('Posts');

    // Query for documents with the specified documentId
    QuerySnapshot<Object?> querySnapshot =
        await collectionReference.where('id', isEqualTo: documentId).get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Loop through the matching documents and update each one
      for (QueryDocumentSnapshot<Object?> documentSnapshot
          in querySnapshot.docs) {
        DocumentReference documentReference =
            collectionReference.doc(documentSnapshot.id);

        // Update the specific field with the new value
        await documentReference.update({
          'report': newValue,
          // Add more fields to update if needed
        });

        print('Document updated successfully');
      }
    } else {
      print('No documents found with the specified documentId');
    }
  } catch (error) {
    print('Error updating document: $error');
  }
}

Future<void> approveSellPlantInFirebase(
    String userId, String documentId, bool newValue) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Get a reference to the collection
    CollectionReference collectionReference =
        firestore.collection('salePlants').doc(userId).collection('SalePlants');

    // Query for documents with the specified documentId
    QuerySnapshot<Object?> querySnapshot =
        await collectionReference.where('id', isEqualTo: documentId).get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Loop through the matching documents and update each one
      for (QueryDocumentSnapshot<Object?> documentSnapshot
          in querySnapshot.docs) {
        DocumentReference documentReference =
            collectionReference.doc(documentSnapshot.id);

        // Update the specific field with the new value
        await documentReference.update({
          'report': newValue,
          // Add more fields to update if needed
        });

        print('Document updated successfully');
      }
    } else {
      print('No documents found with the specified documentId');
    }
  } catch (error) {
    print('Error updating document: $error');
  }
}

Future<void> deletePostInFirebase(String userId, String documentId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Get a reference to the collection
    CollectionReference collectionReference =
        firestore.collection('posts').doc(userId).collection('Posts');

    // Query for documents with the specified documentId
    QuerySnapshot<Object?> querySnapshot =
        await collectionReference.where('id', isEqualTo: documentId).get();

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
      print('No documents found with the specified documentId');
    }
  } catch (error) {
    print('Error deleting document: $error');
  }
}

Future<void> deleteSellPlantInFirebase(String userId, String documentId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Get a reference to the collection
    CollectionReference collectionReference =
        firestore.collection('salePlants').doc(userId).collection('SalePlants');

    // Query for documents with the specified documentId
    QuerySnapshot<Object?> querySnapshot =
        await collectionReference.where('id', isEqualTo: documentId).get();

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
      print('No documents found with the specified documentId');
    }
  } catch (error) {
    print('Error deleting document: $error');
  }
}

Widget _buildButton(String text, Color color, VoidCallback onPressed) {
  return Container(
    width: 150,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: MaterialButton(
      height: 50.0,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}
