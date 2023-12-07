import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/pages/overview/widgets/info_card.dart';

class OverviewCardsHomeScreen extends StatelessWidget {
  OverviewCardsHomeScreen({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference plant = FirebaseFirestore.instance.collection('Plant');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<QuerySnapshot>(
        future: plant.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            // Map<String, dynamic> data =
            //     snapshot.data!.data() as Map<String, dynamic>;
            return Row(
              children: [
                InfoCard(
                  title: "number of plants",
                  value: snapshot.data!.docs.length.toString(),
                  onTap: () {},
                  topColor: Colors.orange,
                ),
                SizedBox(
                  width: width / 64,
                ),
                InfoCard(
                  title: "number of sensor",
                  value: "17",
                  topColor: Colors.lightGreen,
                  onTap: () {},
                ),
                SizedBox(
                  width: width / 64,
                ),
                InfoCard(
                  title: "total mashtaly ",
                  value: "3",
                  topColor: Colors.redAccent,
                  onTap: () {},
                ),
                SizedBox(
                  width: width / 64,
                ),
              ],
            );
          }
          return Text("loading");
        });
  }
}
