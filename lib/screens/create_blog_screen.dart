// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustaqim/core/button_form.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:mustaqim/services/crud.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  CrudMethods crudMethods = CrudMethods();

  TextEditingController blogTitleController = TextEditingController();

  TextEditingController blogDescriptionController = TextEditingController();

  File? image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define your custom text theme here

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
                          height: 160,
                          width: 160,
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.contain,
                          )),
                      const Spacer(),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final pickedImage = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (pickedImage != null) {
                        setState(() {
                          image = File(pickedImage.path);
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorsApp.blackColor, width: 2),
                          color: ColorsApp.greyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: image == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
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
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(image!, fit: BoxFit.cover)),
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
                  const SizedBox(
                    height: 20,
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
