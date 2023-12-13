import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDialogContent extends StatefulWidget {
  String? id;
  PostDialogContent({super.key, required this.id});

  @override
  State<PostDialogContent> createState() => _PostDialogContentState();
}

class _PostDialogContentState extends State<PostDialogContent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Post');
  @override
  Widget build(BuildContext context) {
    String? id = widget.id;
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  Center(
                    child: Column(
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(data['profile_pic']),
                          width: 500,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            sellcard(),
                            SizedBox(
                              width: 10.0,
                            ),
                            sellcard(),
                            SizedBox(
                              width: 10.0,
                            ),
                            sellcard(),
                            SizedBox(
                              width: 10.0,
                            ),
                            sellcard(),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          'Post Title',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more  ',
                          style: TextStyle(
                            fontSize: 23.0,
                          ),
                        ),
                      ],
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

void updateFirestoreValue(String documentId, String newValue) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection('Users');

  try {
    // Get the reference to the document you want to update
    DocumentReference userRef = users.doc(documentId);

    // Update the specific field with the new value
    await userRef.update({
      'fieldName': newValue,
      // Add more fields to update if needed
    });

    print('Document updated successfully');
  } catch (error) {
    print('Error updating document: $error');
  }
}

class sellcard extends StatelessWidget {
  const sellcard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200.0,
          height: 100.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg')),
          ),
        ),
      ],
    );
  }
}
