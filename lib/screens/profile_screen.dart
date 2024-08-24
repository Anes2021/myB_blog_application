// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/core/text_field_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  TextEditingController updateUsernameController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsApp.blackColor, width: 2),
                    borderRadius: BorderRadius.circular(200),
                    color: ColorsApp.greyColor),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt_rounded,
                      color: ColorsApp.whiteColor,
                      size: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Add an image to your Profile",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: ColorsApp.whiteColor,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFieldForm(
                textEditingController: updateUsernameController,
                labelT: "Change Your User Name",
              ),
              const SizedBox(height: 20),
              TextFieldForm(
                textEditingController: updateDescriptionController,
                labelT: "Change Your User Name",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
