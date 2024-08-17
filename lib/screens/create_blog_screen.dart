// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustaqim/core/button_form.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:uuid/uuid.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  bool isSubmitWaiting = false;

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
                  isSubmitWaiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ButtonForm(
                          buttonT: 'Upload',
                          function: _submit,
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

  Future<void> _submit() async {
    setState(() {
      isSubmitWaiting = true;
    });

    //! FORM VALIDATION
    if (blogTitleController.text.trim().isEmpty ||
        blogDescriptionController.text.trim().isEmpty) {
      // message
      setState(() {
        isSubmitWaiting = false;
      });
      return;
    }

    if (!(image == null)) {
      // UPLOAD IMAGE TO STORAGE
      final storage = FirebaseStorage.instance;
      final id = const Uuid().v4();
      final refrence = storage.ref().child("blogs_images/$id");
      await refrence.putFile(image!);
      String imageUrl = await refrence.getDownloadURL();

      // UPLOAD data to firestore
      final firestore = FirebaseFirestore.instance;
      final BlogModel blogModel = BlogModel(
          id: id,
          title: blogTitleController.text.trim(),
          description: blogDescriptionController.text.trim(),
          imageUrl: imageUrl);

      await firestore.collection("blogs").doc(id).set(blogModel.toJson());

      // urkoqskrmlkgdldsk
    } else {
      final id = const Uuid().v4();
      final firestore = FirebaseFirestore.instance;
      final BlogModel blogModel = BlogModel(
          id: id,
          title: blogTitleController.text.trim(),
          description: blogDescriptionController.text.trim(),
          imageUrl: "");

      await firestore.collection("blogs").doc(id).set(blogModel.toJson());
    }

    // message success

    setState(() {
      isSubmitWaiting = false;
    });
  }
}

class BlogModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  BlogModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // Convert a BlogModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // Create a BlogModel instance from a JSON map.
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
