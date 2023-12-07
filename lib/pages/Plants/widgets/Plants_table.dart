import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants/image_strings.dart';
import '../../../widgets/top_nav.dart';

class PlantsTableScreen extends StatefulWidget {
  @override
  _PlantsTableState createState() => _PlantsTableState();
}

class _PlantsTableState extends State<PlantsTableScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference plant = FirebaseFirestore.instance.collection('Plant');
  List<Map<String, dynamic>>? plantData;
  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    QuerySnapshot querySnapshot = await plant.get();
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
          child: plantData == null
              ? const Center(child: CircularProgressIndicator())
              : DataTable2(
                  columnSpacing: 12,
                  dataRowHeight: 60,
                  headingRowHeight: 40,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text("ID"),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Date'),
                    ),
                    DataColumn(
                      label: Text('plant'),
                    ),
                  ],
                  rows: plantData!
                      .map(
                        (plant) => DataRow(
                          cells: [
                            DataCell(Text('${plant['ID']}')),
                            DataCell(Text('${plant['Name']}')),
                            DataCell(Text('${plant['Date']}')),
                            DataCell(InkWell(
                              onTap: () {},
                              child: IconButton(
                                  icon: const Image(
                                    image: AssetImage(
                                      menuIfnoIcon,
                                    ),
                                    width: 25,
                                  ),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    UserName(
                                      username: '',
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
