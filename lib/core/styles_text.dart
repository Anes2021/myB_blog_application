import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mustaqim/core/colors.dart';

class TextStyleForms {
  static TextStyle textFieldStyle = GoogleFonts.aBeeZee(
    textStyle: const TextStyle(
        fontSize: 18, color: ColorsApp.greyColor, fontWeight: FontWeight.bold),
  );
  static TextStyle textFieldTextStyle = GoogleFonts.aBeeZee(
    textStyle: const TextStyle(
        fontSize: 18, color: ColorsApp.blackColor, fontWeight: FontWeight.bold),
  );
  static TextStyle buttonStyle = GoogleFonts.aBeeZee(
    textStyle: const TextStyle(
        fontSize: 22, color: ColorsApp.whiteColor, fontWeight: FontWeight.bold),
  );
}
