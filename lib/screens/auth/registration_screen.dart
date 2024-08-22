// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Blogify',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Made By Haneef Syed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: 'UserName Controller',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isSubmit
                  ? null
                  : () async {
                      await _register();
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              child: Text(
                isSubmit ? "WAIT .." : 'Sign Up',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    //
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )),
            )
          ],
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
          createdAt: DateTime.now());

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

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  // Convert a UserModel instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
