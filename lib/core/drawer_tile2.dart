import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';

class DrawerTile2 extends StatelessWidget {
  final String text;
  final IconData iconT;
  final Function() function;

  const DrawerTile2(
      {super.key,
      required this.text,
      required this.function,
      required this.iconT});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: ColorsApp.whiteColor,
            border: Border.all(color: ColorsApp.blackColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(
                iconT,
                color: ColorsApp.blackColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyleForms.headLineStyle02,
              )
            ],
          ),
        ),
      ),
    );
  }
}
