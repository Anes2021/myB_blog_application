import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';

class TextFieldForm extends StatefulWidget {
  final String? labelT;
  final TextEditingController textEditingController;

  const TextFieldForm(
      {super.key, this.labelT, required this.textEditingController});
  @override
  State<TextFieldForm> createState() => _TextFieldFormState();
}

class _TextFieldFormState extends State<TextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      style: TextStyleForms.textFieldTextStyle,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsApp.blackColor,
          ), // Black border color
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorsApp.blackColor,
              width: 2), // Black border color when focused
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorsApp.blackColor,
              width: 2), // Black border color when enabled
        ),
        labelText: widget.labelT ?? "Text",
        labelStyle: TextStyleForms.textFieldStyle,
      ),
    );
  }
}
