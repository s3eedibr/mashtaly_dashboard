import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';

import 'Dialog.dart';

class AccountTableScreen extends StatefulWidget {
  @override
  _AccountTableState createState() => _AccountTableState();
}

class _AccountTableState extends State<AccountTableScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference account = FirebaseFirestore.instance.collection('Users');
  List<Map<String, dynamic>>? accountData;
  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
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
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        height: (60 * 7) + 40,
        child: accountData == null
            ? const Center(child: CircularProgressIndicator())
            : DataTable2(
                columnSpacing: 12,
                dataRowHeight: 60,
                headingRowHeight: 40,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(label: Text(''), size: ColumnSize.S),
                  DataColumn2(
                    label: Text("Name"),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Location'),
                  ),
                  DataColumn(
                    label: Text('ID'),
                  ),
                  DataColumn(
                    label: Text('Action'),
                  ),
                ],
                rows: accountData!
                    .map(
                      (account) => DataRow(
                        cells: [
                          DataCell(
                            ClipOval(
                                child: Image.network(account['image'],
                                    width: 50, height: 50, fit: BoxFit.cover)),
                          ),
                          DataCell(Text('${account['ID']}')),
                          DataCell(CustomText(text: '${account['location']}')),
                          const DataCell(Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                text: "01368",
                              )
                            ],
                          )),
                          DataCell(
                            IconButton(
                              icon: const Image(
                                image: AssetImage(
                                  menuIfnoIcon,
                                ),
                                width: 25,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 600.0),
                                          child: MyDialogContent(
                                            id: account['hashId'],
                                          )),
                                      actions: [
                                        MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius as needed
                                            ),
                                            color: Colors.green,
                                            height: 50.0,
                                            child: const Text(
                                              'Reset Password',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {}),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius as needed
                                            ),
                                            color: Colors.green,
                                            height: 50.0,
                                            child: const Text(
                                              'Activate',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {}),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Adjust the radius as needed
                                            ),
                                            color: Colors.orange[800],
                                            height: 50.0,
                                            child: const Text(
                                              'Deactivate',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {}),
                                        const SizedBox(
                                          width: 70.0,
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
}
