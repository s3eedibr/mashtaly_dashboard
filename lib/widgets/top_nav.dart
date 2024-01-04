import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';
import 'custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

PreferredSizeWidget topNavigationBar(
        BuildContext context, GlobalKey<ScaffoldState> key) =>
    PreferredSize(
      preferredSize: Size.fromHeight(55),
      child: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset(
              tLogo,
              height: 55,
              width: 55,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 5,
            ),
            const CustomText(
              text: "Mashtaly Dashboard",
              color: tPrimaryTextColor,
              size: 18,
              weight: FontWeight.bold,
            ),
            Expanded(child: Container()),
            UserName(
              username: '',
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                decoration: BoxDecoration(
                    color: tPrimaryActionColor,
                    borderRadius: BorderRadius.circular(65)),
                padding: const EdgeInsets.all(1),
                margin: const EdgeInsets.all(1),
                child: ProfileImage(
                  profile_pic: '',
                ))
          ],
        ),
        elevation: 0,
      ),
    );

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

class ProfileImage extends StatelessWidget {
  final String profile_pic;
  ProfileImage({super.key, required this.profile_pic});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
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
              child: ClipOval(
                child: Image.network(
                  data['profile_pic'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          return Container();
        });
  }
}

class UserName extends StatelessWidget {
  final String username;

  UserName({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
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
            return Text(
              data['name'],
              style: TextStyle(
                  color: tPrimaryTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            );
          }
          return Container();
        });
  }
}
