import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//this page checked
//appbar show logo on project and setting and name of user
AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(
              tLogo,
              width: 40,
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          const CustomText(
            text: "Mashtaly Dashboard",
            color: lightGrey,
            size: 20,
            weight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          UserName(
            username: '',
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: active.withOpacity(.5),
                borderRadius: BorderRadius.circular(30)),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: ProfileImage(
                  profile_pic: '',
                )),
          )
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('Users');

class ProfileImage extends StatelessWidget {
  late String profile_pic;
  ProfileImage({super.key, required this.profile_pic});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc('vJPcD22s2l5bFcqFZNKA').get(),
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
            return CircleAvatar(
              child: ClipOval(
                child: Image.network(data['image'],
                    width: 55, height: 55, fit: BoxFit.cover),
              ),
            );
          }
          return Text("loading");
        });
  }
}

class UserName extends StatelessWidget {
  late String username;

  UserName({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc('vJPcD22s2l5bFcqFZNKA').get(),
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
            return CustomText(
              text: data['name'],
              color: tPrimaryActionColor,
              size: 21,
            );
          }
          return Text("loading");
        });
  }
}
