import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDialogContent extends StatefulWidget {
  String? id;
  AccountDialogContent({super.key, required this.id});

  @override
  State<AccountDialogContent> createState() => _AccountDialogContentState();
}

class _AccountDialogContentState extends State<AccountDialogContent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
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
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(data['image']),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Articles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Articles(),
                            SizedBox(
                              width: 10.0,
                            ),
                            Articles(),
                            SizedBox(
                              width: 10.0,
                            ),
                            Articles(),
                            SizedBox(
                              width: 10.0,
                            ),
                            Articles(),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Articles(),
                        SizedBox(
                          width: 10.0,
                        ),
                        Articles(),
                        SizedBox(
                          width: 10.0,
                        ),
                        Articles(),
                        SizedBox(
                          width: 10.0,
                        ),
                        Articles(),
                        SizedBox(
                          width: 10.0,
                        ),
                        SizedBox(
                          height: 50.0,
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

class Articles extends StatelessWidget {
  const Articles({
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
        const Text(
          'How to plant',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        const Text(
          'by mhamd bl3awi',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
