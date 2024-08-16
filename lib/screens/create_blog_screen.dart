// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mustaqim/core/button_form.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/text_field_form.dart';

class CreateBlogScreen extends StatelessWidget {
  CreateBlogScreen({super.key});

  TextEditingController blogTitleController = TextEditingController();
  TextEditingController blogDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorsApp.whiteColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: ColorsApp.blueColor,
                        size: 25,
                      ),
                      const Spacer(),
                      SizedBox(
                          height: 175,
                          width: 175,
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.contain,
                          )),
                      const Spacer(),
                    ],
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorsApp.blackColor, width: 2),
                        color: ColorsApp.greyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            size: 50,
                            color: ColorsApp.whiteColor,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Tap here to add photo",
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsApp.whiteColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldForm(
                    textEditingController: blogTitleController,
                    labelT: 'Title',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldForm(
                      textEditingController: blogDescriptionController,
                      labelT: 'Description'),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonForm(
                    buttonT: 'Upload',
                    function: test,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void test() {
    log("it Worked");
  }
}
