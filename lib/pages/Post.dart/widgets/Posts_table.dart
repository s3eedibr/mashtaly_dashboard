import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mashtaly_dashboard/pages/SellPlant.dart/widgets/sellDialog.dart';

import '../../../constants/image_strings.dart';
import '../../../getData/getData.dart';
import 'PostDialog.dart';

class PostTableScreen extends StatefulWidget {
  @override
  _PostsTableState createState() => _PostsTableState();
}

class _PostsTableState extends State<PostTableScreen> {
  List<Map<String, dynamic>>? plantData;
  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    await Future.delayed(Duration(seconds: 1));
    plantData = await getAllPosts();
    setState(() {});
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
          height: 700,
          child: plantData == null
              ? Center(child: CircularProgressIndicator())
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
                      label: Text('user'),
                    ),
                    DataColumn(
                      label: Text('Date'),
                    ),
                    DataColumn(
                      label: Text('Post'),
                    ),
                  ],
                  rows: plantData!
                      .map(
                        (post) => DataRow(
                          cells: [
                            DataCell(Text('${post['id']}')),
                            DataCell(Text('${post['user']}')),
                            DataCell(DateParse(
                              firebaseDateString: '${post['date']}',
                            )),
                            DataCell(InkWell(
                              onTap: () {},
                              child: IconButton(
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
                                                maxWidth: 850,
                                                minWidth: 850.0,
                                                minHeight: 800,
                                              ),
                                              child: PostDialogContent(
                                                user_id: post['user_id'],
                                                post_id: post['id'],
                                              )),
                                          actions: [
                                            Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: MaterialButton(
                                                  height: 50.0,
                                                  child: const Text(
                                                    'Accept',
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
                                                                'Are you sure?'),
                                                          ),
                                                          actions: [
                                                            _buildButton('Yes',
                                                                Colors.green,
                                                                () {
                                                              approvePostInFirebase(
                                                                  post[
                                                                      'user_id'],
                                                                  post[
                                                                      'post_id'],
                                                                  true);
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                            _buildButton(
                                                                'No',
                                                                Colors.orange[
                                                                    800]!, () {
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
                                                color: Colors.orange[800],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: MaterialButton(
                                                  height: 50.0,
                                                  child: const Text(
                                                    'Reject',
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
                                                              maxWidth: 200.0,
                                                              maxHeight: 60,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                TextField(
                                                                  decoration: InputDecoration(
                                                                      labelText:
                                                                          'reason for rejection',
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20))),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            _buildButton('Yes',
                                                                Colors.green,
                                                                () {
                                                              approvePostInFirebase(
                                                                  post[
                                                                      'user_id'],
                                                                  post[
                                                                      'post_id'],
                                                                  false);
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                            _buildButton(
                                                                'No',
                                                                Colors.orange[
                                                                    800]!, () {
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
  late String firebaseDateString;
  DateParse({super.key, required this.firebaseDateString});
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(firebaseDateString);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return Text(formattedDate);
  }
}

void approvePostInFirebase(String userId, String post_id, bool newValue) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference post =
      firestore.collection('posts').doc(userId).collection('Posts');

  try {
    // Get the reference to the document you want to update
    QuerySnapshot userRef = await post.where('id', isEqualTo: post_id).get();
    for (QueryDocumentSnapshot documentSnapshot in userRef.docs) {
      // Get the reference to the document
      DocumentReference documentReference = post.doc(documentSnapshot.id);
      // Update the specific field with the new value
      await documentReference.update({
        'posted': newValue,
      });
    }

    print('Document updated successfully');
  } catch (error) {
    print('Error updating document: $error');
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
