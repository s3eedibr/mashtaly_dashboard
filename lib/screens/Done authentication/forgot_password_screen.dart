import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';

import '../../widgets/snackBar.dart';

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
          FirebaseFirestore.instance.collection('users');

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
        showSnakBar(context, 'Enter your email please.');
      else if (!isEmail(_emilController.text.trim()))
        showSnakBar(context, 'The email address is badly formatted.');
      else if (await doesEmailExist(_emilController.text.trim())) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emilController.text.trim());
        showSnakBar(
          context,
          'Password reset instructions sent to your email',
          color: tPrimaryActionColor,
        );
      }

      setState(() {});
    }
  }

  @override
  @override
  void dispose() {
    _emilController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bgLogin.png',
              ), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(160),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Image.asset(
                        tLogo,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Column(
                        children: [
                          // Text(
                          //   "Rest Password",
                          //   style: TextStyle(
                          //     color: tPrimaryTextColor,
                          //     fontSize: 25,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Enter the email associated with your account to receive reset instructions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: tPrimaryTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _emilController,
                          cursorColor: tPrimaryActionColor,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: tSecondActionColor,
                              size: 28,
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(color: tSecondActionColor),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: tPrimaryActionColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: tPrimaryActionColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
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
                              borderRadius: BorderRadius.circular(6)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Send Instructions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => AuthenticationPage()),
                      //     );
                      //   },
                      //   child: CustomText(
                      //       text: "Login", color: tPrimaryActionColor),
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
