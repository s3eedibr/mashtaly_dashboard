import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/style.dart';

import 'AccountDialog.dart';

class AccountTableScreen extends StatefulWidget {
  @override
  _AccountTableState createState() => _AccountTableState();
}

class _AccountTableState extends State<AccountTableScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference account = FirebaseFirestore.instance.collection('users');
  List<Map<String, dynamic>>? accountData;
  @override
  void initState() {
    super.initState();
    fetchAccountData();
  }

  Future<void> fetchAccountData() async {
    QuerySnapshot querySnapshot = await account.get();
    setState(() {
      accountData = querySnapshot.docs
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
      // padding: const EdgeInsets.only(
      //   left: 16,
      //   right: 16,
      // ),
      // margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        height: 550,
        child: accountData == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: tPrimaryActionColor,
                ),
              )
            : DataTable2(
                columnSpacing: 15,
                dataRowHeight: 65,
                headingRowHeight: 40,
                horizontalMargin: 10,
                minWidth: 600,
                columns: [
                  DataColumn2(
                    label: Text(''),
                    size: ColumnSize.S,
                    fixedWidth: 65,
                  ),
                  DataColumn2(
                    label: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    size: ColumnSize.M,
                    fixedWidth: 150,
                  ),
                  DataColumn2(
                    label: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(
                    label: Text(
                      'ID',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    size: ColumnSize.L,
                    fixedWidth: 310,
                  ),
                  DataColumn2(
                    label: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    size: ColumnSize.S,
                    fixedWidth: 75,
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
                rows: accountData!
                    .map(
                      (account) => DataRow(
                        cells: [
                          DataCell(
                            ClipOval(
                                child: Image.network(account['profile_pic'],
                                    width: 50, height: 50, fit: BoxFit.cover)),
                          ),
                          DataCell(Text('${account['name']}')),
                          DataCell(Text('${account['email']}')),
                          DataCell(
                            Text('${account['id']}'),
                          ),
                          DataCell(Text(account['active'] == false
                              ? 'Disabled'
                              : 'Active')),
                          DataCell(
                            IconButton(
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
                                          child: AccountDialogContent(
                                        userID: account['id'],
                                      )),
                                      actions: [
                                        MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius as needed
                                            ),
                                            color: tPrimaryActionColor,
                                            height: 50.0,
                                            child: const Text(
                                              'Reset Password',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 200.0),
                                                      child: Text(
                                                        'Are you sure you want to send rest password for ${account['name']}?',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
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
                                                                  .circular(10),
                                                        ),
                                                        child: MaterialButton(
                                                            height: 50.0,
                                                            child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await _resetPassword(
                                                                  account[
                                                                      'email']);
                                                              await fetchAccountData();
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
                                                                  .circular(10),
                                                        ),
                                                        child: MaterialButton(
                                                            height: 50.0,
                                                            child: const Text(
                                                              'No',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            onPressed: () {
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
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius as needed
                                            ),
                                            color: tPrimaryActionColor,
                                            height: 50.0,
                                            child: const Text(
                                              'Activate',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 200.0),
                                                      child: Text(
                                                        'Are you sure you want to activate ${account['name']}?',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
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
                                                                  .circular(10),
                                                        ),
                                                        child: MaterialButton(
                                                            height: 50.0,
                                                            child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await activeAccountInFirebase(
                                                                account['id'],
                                                              );
                                                              await fetchAccountData();
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
                                                                  .circular(10),
                                                        ),
                                                        child: MaterialButton(
                                                            height: 50.0,
                                                            child: const Text(
                                                              'No',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            onPressed: () {
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
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Adjust the radius as needed
                                          ),
                                          color: tThirdTextErrorColor,
                                          height: 50.0,
                                          child: const Text(
                                            'Deactivate',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 200.0),
                                                    child: Text(
                                                      'Are you sure you want to deactivate ${account['name']}?',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  actions: [
                                                    Container(
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            tPrimaryActionColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: MaterialButton(
                                                          height: 50.0,
                                                          child: const Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            await deactivateAccountInFirebase(
                                                                account['id']);
                                                            await fetchAccountData();
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            tThirdTextErrorColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: MaterialButton(
                                                          height: 50.0,
                                                          child: const Text(
                                                            'No',
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 80.0,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  Future<void> activeAccountInFirebase(String userId) async {
    try {
      // Update the user profile in Firestore to indicate that the account is disabled
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'active': true,
      });

      // Update 'active' field in all posts associated with the user
      QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts')
          .get();

      for (QueryDocumentSnapshot postDoc in postsSnapshot.docs) {
        await postDoc.reference.update({'active': true});
      }

      // Update 'active' field in all sell plants associated with the user
      QuerySnapshot sellPlantsSnapshot = await FirebaseFirestore.instance
          .collection('salePlants')
          .doc(userId)
          .collection('SalePlants')
          .get();

      for (QueryDocumentSnapshot sellPlantDoc in sellPlantsSnapshot.docs) {
        await sellPlantDoc.reference.update({'active': true});
      }

      print('Updated successfully');
    } catch (e) {
      print('Error disabling user account: $e');
    }
  }

  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // Show a success message or navigate to a success screen
      print('Password reset email sent successfully.');
    } catch (e) {
      // Show an error message
      print('Error sending password reset email: $e');
    }
  }

  Future<void> deactivateAccountInFirebase(String userId) async {
    try {
      // Update the user profile in Firestore to indicate that the account is disabled
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'active': false,
      });

      // Update 'active' field in all posts associated with the user
      QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('Posts')
          .get();

      for (QueryDocumentSnapshot postDoc in postsSnapshot.docs) {
        await postDoc.reference.update({'active': false});
      }

      // Update 'active' field in all sell plants associated with the user
      QuerySnapshot sellPlantsSnapshot = await FirebaseFirestore.instance
          .collection('salePlants')
          .doc(userId)
          .collection('SalePlants')
          .get();

      for (QueryDocumentSnapshot sellPlantDoc in sellPlantsSnapshot.docs) {
        await sellPlantDoc.reference.update({'active': false});
      }

      print('Updated successfully');
    } catch (e) {
      print('Error disabling user account: $e');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
