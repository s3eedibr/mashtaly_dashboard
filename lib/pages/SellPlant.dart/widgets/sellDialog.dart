import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';

class SellDialogContent extends StatefulWidget {
  String? user_id, post_id;
  SellDialogContent({super.key, required this.user_id, required this.post_id});

  @override
  State<SellDialogContent> createState() => _SellDialogContentState();
}

class _SellDialogContentState extends State<SellDialogContent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Post');
  @override
  Widget build(BuildContext context) {
    String? user_id = widget.user_id;
    String? post_id = widget.post_id;
    CollectionReference users = FirebaseFirestore.instance
        .collection('SalePlants')
        .doc(user_id)
        .collection('SalePlants');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(post_id).get(),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data['sale_pic1'],
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
                                width: 600,
                                height: 300,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
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
                            sellcard(img: data['sale_pic2']),
                            SizedBox(
                              width: 10.0,
                            ),
                            sellcard(img: data['sale_pic3']),
                            SizedBox(
                              width: 10.0,
                            ),
                            sellcard(img: data['sale_pic4']),
                            SizedBox(
                              width: 10.0,
                            ),
                            sellcard(img: data['sale_pic5']),
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
                        Row(
                          children: [
                            Text(
                              data['title'],
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              data['phone_number'],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: tPrimaryActionColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          data['content'],
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

class sellcard extends StatelessWidget {
  String? img;
  sellcard({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return img == ''
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    img!,
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
                        width: 200.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
