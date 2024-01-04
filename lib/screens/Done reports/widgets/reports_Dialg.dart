import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Done articles/widgets/articles_dialog.dart';

class ReportingDialogContent extends StatefulWidget {
  final String? user_id, post_id;
  ReportingDialogContent(
      {super.key, required this.user_id, required this.post_id});

  @override
  State<ReportingDialogContent> createState() => _ReportingDialogContentState();
}

class _ReportingDialogContentState extends State<ReportingDialogContent> {
  @override
  Widget build(BuildContext context) {
    String? userId = widget.user_id;
    String? postId = widget.post_id;
    CollectionReference dataFromFire = FirebaseFirestore.instance
        .collection('posts')
        .doc(userId)
        .collection('Posts');

    return FutureBuilder<QuerySnapshot>(
        future: dataFromFire.where('id', isEqualTo: postId).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text("Document does not exist");
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
                            data['post_pic1'],
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
                            data['post_pic2'] != null
                                ? PostCard(img: data['post_pic2'])
                                : Container(),
                            SizedBox(
                              width: 10.0,
                            ),
                            data['post_pic3'] != null
                                ? PostCard(img: data['post_pic3'])
                                : Container(),
                            SizedBox(
                              width: 10.0,
                            ),
                            data['post_pic4'] != null
                                ? PostCard(img: data['post_pic4'])
                                : Container(),
                            SizedBox(
                              width: 10.0,
                            ),
                            data['post_pic5'] != null
                                ? PostCard(img: data['post_pic5'])
                                : Container(),
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
                          data['title'],
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
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

class postcard extends StatelessWidget {
  final String? img;
  postcard({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return img == ''
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    img!,
                    width: 200.0,
                    height: 100.0,
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
              ),
            ],
          );
  }
}
