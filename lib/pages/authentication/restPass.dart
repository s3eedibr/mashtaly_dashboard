import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';

import 'authentication.dart';

class RestPasswordPage extends StatefulWidget {
  const RestPasswordPage({super.key});

  @override
  State<RestPasswordPage> createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPasswordPage> {
  final _emilController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isEmail(String em) {
    String p = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<bool> doesEmailExist(String email) async {
    try {
      // Reference to the Firestore collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');

      // Query for a document where the 'email' field matches the specified email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      // Check if any documents were found
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false; // Return false in case of an error
    }
  }

  Future rest() async {
    if (formKey.currentState!.validate()) {
      if (_emilController.text.isEmpty)
        showSnackBar(context, 'Enter your email please.');
      else if (!isEmail(_emilController.text.trim()))
        showSnackBar(context, 'The email address is badly formatted.');
      else if (await doesEmailExist(_emilController.text.trim())) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emilController.text.trim());
        showSnackBar(context, 'Password reset instructions sent to your email');
      }

      setState(() {});
    }
  }

  void showSnackBar(BuildContext context, String message,
      {Color color = tThirdTextErrorColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: tBgColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  @override
  void dispose() {
    _emilController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: tBgColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Mashtaly Dashboard',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bgLogin.png',
              ), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(120),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: tBgColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Image.asset(
                                tLogo,
                                width: 200,
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "Rest Password",
                              style: TextStyle(
                                fontFamily: 'Mulish',
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            CustomText(
                              text:
                                  "Enter your account email for reset instructions.",
                              color: lightGrey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return 'field is requierd';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _emilController,
                                cursorColor: tPrimaryActionColor,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "abc@domain.com",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthenticationPage()),
                                );
                              },
                              child: CustomText(
                                  text: "Login", color: tPrimaryActionColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () async {
                            rest();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: tPrimaryActionColor,
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const CustomText(
                              text: "Send Instructions",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
