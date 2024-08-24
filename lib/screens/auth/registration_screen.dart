// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:mustaqim/screens/auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //* 1: create an instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //* 2: Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  //* 4: create waiting bools
  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/images/app_icon_scaled.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 40),
              //controller: userNameController,
              TextFieldForm(
                textEditingController: userNameController,
                labelT: "Username",
              ),
              const SizedBox(height: 16),
              TextFieldForm(
                textEditingController: emailController,
                labelT: "Email",
              ),
              const SizedBox(height: 16),
              TextFieldForm(
                textEditingController: passwordController,
                labelT: "Password",
              ),
              const SizedBox(height: 24),

              GestureDetector(
                onTap: isSubmit
                    ? null
                    : () async {
                        await _register();
                      },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorsApp.blackColor
                              .withOpacity(0.3), // Shadow color with opacity
                          spreadRadius: 5.0, // Spread radius of the shadow
                          blurRadius: 10.0, // Blur radius of the shadow
                          offset: const Offset(0,
                              4), // Offset of the shadow (horizontal, vertical)
                        ),
                      ],
                      border: Border.all(color: ColorsApp.blackColor, width: 2),
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0XFF4258E1)),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSubmit ? "WAIT .." : 'Sign Up',
                          style: TextStyleForms.buttonStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                    onTap: () {
                      //
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: Text("LOGIN", style: TextStyleForms.buttonBlue)),
              )
            ],
          ),
        ),
      ),
    );
  }

  //* 3: Create the submission function
  Future<void> _register() async {
    setState(() {
      isSubmit = true;
    });
    //* start
    //! validation
    if (emailController.text.trim().isEmpty ||
        userNameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CherryToast.warning(
        description: const Text("PLEASE FILL ALL FIELDS"),
      ).show(context);

      setState(() {
        isSubmit = false;
      });

      return;
    }

    //! register
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      //* special case
      final String id = auth.currentUser!.uid;

      final UserModel userModel = UserModel(
          id: id,
          userName: userNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          createdAt: DateTime.now(),
          isAdmin: false);

      //* send to firestore
      await firestore.collection("users").doc(id).set(userModel.toJson());

      CherryToast.success(
        description: const Text("REGISTRATION COMPLETED"),
      ).show(context);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      CherryToast.error(
        description: Text(e.code.toString()),
      ).show(context);
    }

    // * end
    setState(() {
      isSubmit = false;
    });
  }
}

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String password;
  final DateTime createdAt;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.isAdmin,
    required this.userName,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  // Convert a UserModel instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isAdmin': isAdmin,
      'userName': userName,
      'email': email,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a UserModel instance from a Map (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      isAdmin: json['isAdmin'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
