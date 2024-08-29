// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  TextEditingController updateUsernameController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();

  late UserModel userModel;
  bool isWaiting = false;

  File? image;

  late String imageURL;
  bool isImageLoading = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    setState(() {
      isImageLoading = true;
    });
    userModel = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((v) {
      return UserModel.fromJson(v.data()!);
    });
    imageURL = userModel.imageUrl;
    updateDescriptionController.text = userModel.userDescription;
    updateUsernameController.text = userModel.userName;
    if (updateDescriptionController.text.trim().isEmpty) {
      updateDescriptionController.text = "null Status";
    }
    setState(() {
      isImageLoading = false;
    });
  }

  void changeName() async {
    setState(() {
      isWaiting = true;
    });

    if (!(image == null)) {
      // UPLOAD IMAGE TO STORAGE
      final storage = FirebaseStorage.instance;
      final id = const Uuid().v4();
      final refrence = storage.ref().child("blogs_images/$id");
      await refrence.putFile(image!);
      String imageUrl = await refrence.getDownloadURL();

      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({'imageUrl': imageUrl});
    }
    firestore.collection("users").doc(auth.currentUser!.uid).update({
      "userName": updateUsernameController.text,
      "userDescription": updateDescriptionController.text
    });

    QuerySnapshot blogSnapshot = await firestore.collection('blogs').get();

    for (var blogDoc in blogSnapshot.docs) {
      QuerySnapshot commentSnapshot = await firestore
          .collection('blogs')
          .doc(blogDoc.id)
          .collection('comments')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();

      for (var commentDoc in commentSnapshot.docs) {
        // Update the userName field in each comment document
        await firestore
            .collection('blogs')
            .doc(blogDoc.id)
            .collection('comments')
            .doc(commentDoc.id)
            .update({
          'username': updateUsernameController.text,
        });
      }
    }
    imageURL = userModel.imageUrl;
    CherryToast.success(
        title: Text(
      "Changes Saved.",
      style: TextStyleForms.headLineStyle03,
    )).show(context);
    setState(() {
      isWaiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 21, color: ColorsApp.blueColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Profile",
                  style: TextStyleForms.buttonBlue,
                ),
              ],
            ),
          ],
        ),
        backgroundColor: ColorsApp.whiteColor,
      ),
      body: isImageLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
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
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorsApp.blackColor, width: 2),
                            borderRadius: BorderRadius.circular(200),
                            color: ColorsApp.greyColor,
                          ),
                          child: (image == null)
                              ? imageURL.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera_alt_rounded,
                                            color: ColorsApp.whiteColor,
                                            size: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Add an image to your Profile",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: ColorsApp.whiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: Image.network(
                                        imageURL.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFieldForm(
                      textEditingController: updateUsernameController,
                      labelT: "Change Your User Name",
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    TextFieldForm(
                      textEditingController: updateDescriptionController,
                      labelT: "Set Your Status",
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: isWaiting ? null : changeName,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorsApp.blackColor.withOpacity(
                                    0.3), // Shadow color with opacity
                                spreadRadius:
                                    5.0, // Spread radius of the shadow
                                blurRadius: 10.0, // Blur radius of the shadow
                                offset: const Offset(0,
                                    4), // Offset of the shadow (horizontal, vertical)
                              ),
                            ],
                            border: Border.all(
                                color: ColorsApp.blackColor, width: 2),
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0XFF4258E1)),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isWaiting ? "Wait . . ." : "Save Changes",
                                style: TextStyleForms.buttonStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
