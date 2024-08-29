// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:mustaqim/main.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //* 1: create an instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  //* 2: Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                width: 10,
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
              TextFieldForm(
                textEditingController: emailController,
                labelT: "Email",
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextFieldForm(
                textEditingController: passwordController,
                labelT: "Password",
                maxLines: 1,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: isSubmit
                    ? null
                    : () async {
                        await _login();
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
                          isSubmit ? "WAIT .." : 'Login',
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
                        builder: (context) => const SignUpScreen(),
                      ));
                    },
                    child: Text("REGISTER", style: TextStyleForms.buttonBlue)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      isSubmit = true;
    });
    //* start
    //! validation
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CherryToast.warning(
        description: const Text("PLEASE FILL ALL FIELDS"),
      ).show(context);

      setState(() {
        isSubmit = false;
      });

      return;
    }

    //*

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      CherryToast.success(
        description: const Text("REGISTRATION COMPLETED"),
      ).show(context);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainApp(),
      ));
    } on FirebaseAuthException catch (e) {
      CherryToast.error(
        description: Text(e.code.toString()),
      ).show(context);
    }

    setState(() {
      isSubmit = false;
    });
  }
}
