// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/button_form.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:mustaqim/screens/home_screen.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

TextEditingController adminUsrename = TextEditingController();
TextEditingController adminPassword = TextEditingController();

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorsApp.blueColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/images/app_icon.png',
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFieldForm(
                  textEditingController: adminUsrename,
                  labelT: 'Admin Username',
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldForm(
                    textEditingController: adminPassword,
                    maxLines: 1,
                    labelT: 'Admin Password'),
                const SizedBox(
                  height: 20,
                ),
                ButtonForm(
                  buttonT: "Login as Admin",
                  function: () {
                    if (adminUsrename.text == "Hellalet" &&
                        adminPassword.text == "0550452418") {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const HomeScreen(),
                      //   ));
                      CherryToast.success(
                        description: Text(
                          "Your're an Admin Now",
                          style: TextStyleForms.headLineStyle03,
                        ),
                      ).show(context);
                      return;
                    } else if (adminUsrename.text.trim().isEmpty ||
                        adminPassword.text.trim().isEmpty) {
                      CherryToast.error(
                        description: Text(
                          "Fill The Fields With The Correct Answers",
                          style: TextStyleForms.headLineStyle03,
                        ),
                      ).show(context);
                      return;
                    }
                    if (adminUsrename.text != "Hellalet" &&
                        adminPassword.text != "0550452418") {
                      CherryToast.error(
                        description: Text(
                          "inCorrect Answers",
                          style: TextStyleForms.headLineStyle03,
                        ),
                      ).show(context);
                      return;
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
