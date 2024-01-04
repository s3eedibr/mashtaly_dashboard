import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constants/colors.dart';
import '../../../getData/getData.dart';

class AccountDialogContent extends StatefulWidget {
  final String? userID;
  AccountDialogContent({super.key, required this.userID});

  @override
  State<AccountDialogContent> createState() => _AccountDialogContentState();
}

class _AccountDialogContentState extends State<AccountDialogContent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? id;
  @override
  Widget build(BuildContext context) {
    id = widget.userID;

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
                          radius: 60,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plants for sale',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
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
          return Text("");
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
            return CircularProgressIndicator(
              color: tPrimaryActionColor,
            );
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
            return CircularProgressIndicator(
              color: tPrimaryActionColor,
            ); // Display shimmer loading animation while waiting for data
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

  Widget buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'), // Display an error message
    );
  }

  Widget buildPostsListView(List<Map<String, dynamic>> posts) {
    return SizedBox(
      width: 650,
      height: 215,
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
      height: 215,
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
  final String name;
  final String pic;
  final String title;
  AccountCard({
    Key? key,
    required this.name,
    required this.pic,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: SizedBox(
                          height: 150,
                          width: 250,
                          child: pic.isNotEmpty
                              ? Image.network(
                                  pic,
                                  height: 150,
                                  width: 250,
                                  fit: BoxFit.cover,
                                )
                              : CircularProgressIndicator(
                                  color: tPrimaryActionColor,
                                )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: tPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
