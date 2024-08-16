import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';

class ButtonForm extends StatefulWidget {
  final Function()? function;
  final String buttonT;
  const ButtonForm({super.key, required this.buttonT, this.function});

  @override
  State<ButtonForm> createState() => _ButtonFormState();
}

class _ButtonFormState extends State<ButtonForm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorsApp.blackColor
                    .withOpacity(0.3), // Shadow color with opacity
                spreadRadius: 5.0, // Spread radius of the shadow
                blurRadius: 10.0, // Blur radius of the shadow
                offset: const Offset(
                    0, 4), // Offset of the shadow (horizontal, vertical)
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
                widget.buttonT,
                style: TextStyleForms.buttonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
