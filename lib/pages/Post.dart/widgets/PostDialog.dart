import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDialogContent extends StatefulWidget {
  String? user_id, post_id;
  PostDialogContent({super.key, required this.user_id, required this.post_id});

  @override
  State<PostDialogContent> createState() => _PostDialogContentState();
}

class _PostDialogContentState extends State<PostDialogContent> {
  @override
  Widget build(BuildContext context) {
    String? user_id = widget.user_id;
    String? post_id = widget.post_id;
    CollectionReference users = FirebaseFirestore.instance
        .collection('posts')
        .doc(user_id)
        .collection('Posts');

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
                        Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            data['sale_pic1'],
                          ),
                          width: 600,
                          height: 300,
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
                            postcard(img: data['sale_pic2']),
                            SizedBox(
                              width: 10.0,
                            ),
                            postcard(img: data['sale_pic3']),
                            SizedBox(
                              width: 10.0,
                            ),
                            postcard(img: data['sale_pic4']),
                            SizedBox(
                              width: 10.0,
                            ),
                            postcard(img: data['sale_pic5']),
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
                          data['contact'],
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
  String? img;
  postcard({super.key, required this.img});

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
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(img!)),
                ),
              ),
            ],
          );
  }
}