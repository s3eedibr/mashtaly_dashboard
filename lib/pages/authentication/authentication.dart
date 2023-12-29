import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';
import 'package:mashtaly_dashboard/constants/style.dart';
import 'package:mashtaly_dashboard/pages/authentication/restPass.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<AuthenticationPage>
    with WidgetsBindingObserver {
  bool isloading = false;
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  Future login() async {
    if (formKey.currentState!.validate()) {
      isloading = true;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emilController.text.trim(),
            password: _passwordController.text.trim());
        String uid = FirebaseAuth.instance.currentUser!.uid;

        bool isAdmin = await isAdminUser(uid);
        if (!isAdmin) {
          showSankBar(context, 'No user found for that email.');
          await FirebaseAuth.instance.signOut();
        } else
          Get.offAllNamed(rootRoute);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'invalid-credential') {
          showSankBar(context, 'Incorrect email or password.');
        } else if (e.code == 'user-disabled') {
          showSankBar(context,
              'The user account has been disabled by an administrator.');
        } else if (e.code == 'invalid-email') {
          showSankBar(context, 'The email address is badly formatted');
        } else if (e.code == 'too-many-requests') {
          showSankBar(context,
              'Access to this account has been temporarily disabled due to  many  failed  login attempts');
        }
      } catch (e) {
        showSankBar(context, e.toString());
      }
      isloading = false;
      setState(() {});
    }
  }

  Future<bool> isAdminUser(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userSnapshot.exists) {
        return userSnapshot['isAdmin'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }

  void showSankBar(BuildContext context, String message,
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void dispose() {
    _emilController.dispose();
    _passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                                "Login",
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
                                text: "Welcome back to the admin panel.",
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
                                TextFormField(
                                  validator: (data) {
                                    if (data!.isEmpty) {
                                      return 'field is requierd';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _passwordController,
                                  cursorColor: tPrimaryActionColor,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "123",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
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
                                            RestPasswordPage()),
                                  );
                                },
                                child: CustomText(
                                    text: "Forgot password?",
                                    color: tPrimaryActionColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              login();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: tPrimaryActionColor,
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: const CustomText(
                                text: "Login",
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
      ),
    ));
  }
}
