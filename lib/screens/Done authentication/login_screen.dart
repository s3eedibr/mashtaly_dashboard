import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mashtaly_dashboard/constants/colors.dart';
import 'package:mashtaly_dashboard/constants/image_strings.dart';
import 'package:mashtaly_dashboard/screens/Done%20authentication/forgot_password_screen.dart';
import 'package:mashtaly_dashboard/routing/routes.dart';
import 'package:mashtaly_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../widgets/snackBar.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<AuthenticationPage>
    with WidgetsBindingObserver {
  bool isLoading = false;
  final _emilController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  GlobalKey<FormState> formKey = GlobalKey();

  Future login() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emilController.text.trim(),
            password: _passwordController.text.trim());
        String uid = FirebaseAuth.instance.currentUser!.uid;

        bool isAdmin = await isAdminUser(uid);
        if (!isAdmin) {
          showSnakBar(context, 'This user is not admin.');
          await FirebaseAuth.instance.signOut();
        } else
          Get.offAllNamed(rootRoute);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        switch (e.code) {
          case 'user-not-found':
            showSnakBar(context, 'No user found for that email.');
            break;
          case 'wrong-password':
            showSnakBar(context, 'Incorrect email or password.');
            break;
          case 'user-disabled':
            showSnakBar(context,
                'The user account has been disabled by an administrator.');
            break;
          case 'invalid-email':
            showSnakBar(context, 'The email address is badly formatted.');
            break;
          case 'too-many-requests':
            showSnakBar(context,
                'Access to this account has been temporarily disabled due to many failed login attempts.');
            break;
          case 'invalid-credential':
            showSnakBar(context, 'Incorrect email or password.');
            break;

          default:
            showSnakBar(context, e.toString());
        }
      } catch (e) {
        showSnakBar(context, e.toString());
      }
      isLoading = false;
      setState(() {});
    }
  }

  Future<bool> isAdminUser(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
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
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bgLogin.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(130),
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
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const Text(
                                  "Mashtaly Dashboard",
                                  style: TextStyle(
                                    color: tPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
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
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 12),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: tSecondActionColor,
                                      size: 28,
                                    ),
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: tSecondActionColor),
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
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "This field is required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _passwordController,
                                    cursorColor: tPrimaryActionColor,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: !_showPassword,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: tSecondActionColor,
                                        size: 28,
                                      ),
                                      hintText: "Password",
                                      hintStyle: const TextStyle(
                                          color: tSecondActionColor),
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: tPrimaryActionColor,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: tPrimaryActionColor,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: tSecondActionColor,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
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
                                  borderRadius: BorderRadius.circular(6)),
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
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
    );
  }
}
