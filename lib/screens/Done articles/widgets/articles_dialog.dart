import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';

class PostDialogContent extends StatefulWidget {
  final String? user_id, post_id;
  PostDialogContent({super.key, required this.user_id, required this.post_id});

  @override
  State<PostDialogContent> createState() => _PostDialogContentState();
}

class _PostDialogContentState extends State<PostDialogContent> {
  @override
  Widget build(BuildContext context) {
    String? userId = widget.user_id;
    String? postId = widget.post_id;
    CollectionReference users = FirebaseFirestore.instance
        .collection('posts')
        .doc(userId)
        .collection('Posts');

    return FutureBuilder<QuerySnapshot>(
        future: users.where('id', isEqualTo: postId).get(),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () {
                                  _showImageDialog(context, data['post_pic1']);
                                },
                                child: Image.network(
                                  data['post_pic1'],
                                  width: 600,
                                  height: 300,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: tPrimaryActionColor,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
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
                                if (data['post_pic2'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['post_pic2']);
                                    },
                                    child: PostCard(img: data['post_pic2']),
                                  ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (data['post_pic3'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['post_pic3']);
                                    },
                                    child: PostCard(img: data['post_pic3']),
                                  ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (data['post_pic4'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['post_pic4']);
                                    },
                                    child: PostCard(img: data['post_pic4']),
                                  ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (data['post_pic5'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['post_pic5']);
                                    },
                                    child: PostCard(img: data['post_pic5']),
                                  ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ]),
              ),
            );
          }
          return CircularProgressIndicator(
            color: tPrimaryActionColor,
          );
        });
  }
}

void _showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Image.network(imageUrl),
      );
    },
  );
}

class PostCard extends StatelessWidget {
  final String? img;
  PostCard({
    super.key,
    required this.img,
  });

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
