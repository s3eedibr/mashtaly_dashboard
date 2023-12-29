import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';

/// Example without datasource
class ReportingTable extends StatefulWidget {
  ReportingTable({super.key});

  @override
  State<ReportingTable> createState() => _ReportingTableState();
}

class _ReportingTableState extends State<ReportingTable> {
  late String profilePic =
      'https://firebasestorage.googleapis.com/v0/b/mashtalydashboard2.appspot.com/o/soldier_helmet_art_123765_1280x720.jpg?alt=media&token=5b336d2c-0d7f-45e0-883d-8636e694cd8d';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: SizedBox(
        height: (60 * 7) + 40,
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: SizedBox(
                  height: 110,
                  width: 110,
                  child: CircleAvatar(
                    backgroundColor: tPrimaryActionColor,
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          profilePic,
                          width: 108,
                          height: 108,
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
                              'assets/images/icons/default_profile.jpg',
                              width: 108,
                              height: 108,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 145,
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: CircleAvatar(
                    backgroundColor: tPrimaryActionColor,
                    child: CircleAvatar(
                      backgroundColor: tBgColor,
                      radius: 16.5,
                      child: GestureDetector(
                        onTap: () {
                          //    pickImageAndUpload();
                        },
                        child: const Icon(
                          Icons.mode_edit_rounded,
                          color: tPrimaryActionColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 195),
              //   child: Text(
              //     userName.isEmpty
              //         ? "Mashtaly user"
              //         : userName.toCapitalized(),
              //     style: const TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
