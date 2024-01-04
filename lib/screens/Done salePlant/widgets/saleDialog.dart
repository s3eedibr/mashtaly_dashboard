import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';

class SaleDialogContent extends StatefulWidget {
  final String? user_ID, post_id;
  SaleDialogContent({
    super.key,
    required this.user_ID,
    required this.post_id,
  });

  @override
  State<SaleDialogContent> createState() => _SaleDialogContentState();
}

class _SaleDialogContentState extends State<SaleDialogContent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String? userId = widget.user_ID;
    String? postId = widget.post_id;
    CollectionReference salePlantPost = FirebaseFirestore.instance
        .collection('salePlants')
        .doc(userId)
        .collection('SalePlants');

    return FutureBuilder<QuerySnapshot>(
        future: salePlantPost.where('id', isEqualTo: postId).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
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
                            GestureDetector(
                              onTap: () {
                                _showImageDialog(context, data['sale_pic1']);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data['sale_pic1'],
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
                                if (data['sale_pic2'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['sale_pic2']);
                                    },
                                    child: SaleCard(img: data['sale_pic2']),
                                  ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (data['sale_pic3'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['sale_pic3']);
                                    },
                                    child: SaleCard(img: data['sale_pic3']),
                                  ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (data['sale_pic4'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['sale_pic4']);
                                    },
                                    child: SaleCard(img: data['sale_pic4']),
                                  ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (data['sale_pic5'] != null)
                                  GestureDetector(
                                    onTap: () {
                                      _showImageDialog(
                                          context, data['sale_pic5']);
                                    },
                                    child: SaleCard(img: data['sale_pic5']),
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
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            data['user'],
                            style: TextStyle(
                              fontSize: 20.0,
                              color: tPrimaryTextColor,
                            ),
                          ),
                          Text(
                            data['phone_number'],
                            style: TextStyle(
                              fontSize: 15.0,
                              color: tPrimaryTextColor,
                            ),
                          ),
                          Text(
                            data['content'],
                            style: TextStyle(
                              fontSize: 24.0,
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

class SaleCard extends StatefulWidget {
  final String? img;
  SaleCard({
    super.key,
    required this.img,
  });

  @override
  State<SaleCard> createState() => _SaleCardState();
}

class _SaleCardState extends State<SaleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 100.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          widget.img!,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
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
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Image.asset(
              'assets/images/default_plant.jpg',
              width: 200.0,
              height: 100.0,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
