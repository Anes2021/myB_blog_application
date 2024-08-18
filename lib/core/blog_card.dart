import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';

class BlogCard extends StatefulWidget {
  final String titleText;
  final String DescriptionText;

  const BlogCard(
      {super.key, required this.titleText, required this.DescriptionText});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: 10.0, top: 10.0), // Space between each card
      child: Material(
        elevation: 5.0, // Adjust elevation as needed
        borderRadius:
            BorderRadius.circular(30), // Match with Container's borderRadius
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorsApp.CardColor,
            border: Border.all(
              color: ColorsApp.blackColor,
              width: 2,
            ),
            borderRadius:
                BorderRadius.circular(30), // Adjust the radius value as needed
          ),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: ColorsApp.blackColor, width: 1.5),
                      color: ColorsApp.greyColor,
                    ),
                    child: const Icon(
                      Icons.image,
                      color: ColorsApp.whiteColor,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.titleText,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyleForms.headLineStyle01),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(widget.DescriptionText,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyleForms.headLineStyle03),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
