// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import '../../../getData/getData.dart';
import '../../../models/post.dart';

class AccountDialogContent extends StatefulWidget {
  String? userid;
  AccountDialogContent({super.key, required this.userid});

  @override
  State<AccountDialogContent> createState() => _AccountDialogContentState();
}

class _AccountDialogContentState extends State<AccountDialogContent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  String? id;
  @override
  Widget build(BuildContext context) {
    id = widget.userid;

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
            Map<String, dynamic> account =
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
                          backgroundImage:
                              NetworkImage('${account['profile_pic']}'),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          '${account['name']}',
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
                        height: 10.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildPostList('${account['id']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'sell plant',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildSaleList('${account['id']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          }
          return Text("loading");
        });
  }

  Widget buildPostList(String id) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      color: tPrimaryActionColor,
      backgroundColor: tBgColor,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        // Fetch all posts using the getMyPosts() function
        future: getMyPosts(id),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return buildShimmerList(); // Display shimmer loading animation while waiting for data
          } else if (snapshot.hasError) {
            return buildErrorWidget(snapshot.error
                .toString()); // Display error message if an error occurs
          } else {
            return buildPostsListView(
                snapshot.data!); // Build the post list view
          }
        },
      ),
    );
  }

  Widget buildSaleList(String id) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      color: tPrimaryActionColor,
      backgroundColor: tBgColor,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        // Fetch all posts using the getMyPosts() function
        future: getMySells(id),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return buildShimmerList(); // Display shimmer loading animation while waiting for data
          } else if (snapshot.hasError) {
            return buildErrorWidget(snapshot.error
                .toString()); // Display error message if an error occurs
          } else {
            return buildSaleListView(
                snapshot.data!); // Build the post list view
          }
        },
      ),
    );
  }

  Widget buildShimmerList() {
    return Container(
      child: Text('no data'),
    );
  }

  Widget buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'), // Display an error message
    );
  }

  Widget buildPostsListView(List<Map<String, dynamic>> posts) {
    return SizedBox(
      width: 650,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AccountCard(
              pic: post['post_pic1'],
              title: post['title'],
              name: post['user'],
            ),
          );
        },
      ),
    );
  }

  Widget buildSaleListView(List<Map<String, dynamic>> posts) {
    return SizedBox(
      width: 650,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AccountCard(
              pic: post['sale_pic1'],
              title: post['title'],
              name: post['user'],
            ),
          );
        },
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  late String name;
  late String pic;
  late String title;
  AccountCard({
    Key? key,
    required this.name,
    required this.pic,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200.0,
          height: 100.0,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(pic)),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
