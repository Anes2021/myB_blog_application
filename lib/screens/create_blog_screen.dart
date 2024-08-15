import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateBlogScreen extends StatelessWidget {
  const CreateBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                        color: Color(0XFF4258E1),
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
                        border: Border.all(color: Colors.black, width: 2),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Tap here to add photo",
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ), // Black border color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2), // Black border color when focused
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2), // Black border color when enabled
                        ),
                        labelText: 'Title',
                        labelStyle: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ), // Black border color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2), // Black border color when focused
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2), // Black border color when enabled
                        ),
                        labelText: 'Description',
                        labelStyle: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.3), // Shadow color with opacity
                            spreadRadius: 5.0, // Spread radius of the shadow
                            blurRadius: 10.0, // Blur radius of the shadow
                            offset: const Offset(0,
                                4), // Offset of the shadow (horizontal, vertical)
                          ),
                        ],
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0XFF4258E1)),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upload",
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
