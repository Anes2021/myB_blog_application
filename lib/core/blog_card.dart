import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';

class BlogCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;

  const BlogCard(
      {super.key,
      required this.titleText,
      required this.descriptionText,
      required this.imageUrl});

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
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Aligns column items to the start (left)
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: ColorsApp.blackColor, width: 1.5),
                        color: ColorsApp.greyColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titleText,
                        style: TextStyleForms.headLineStyle01,
                        softWrap:
                            true, // Ensures the text wraps to the next line
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.descriptionText,
                        style: TextStyleForms.headLineStyle03,
                        softWrap:
                            true, // Ensures the text wraps to the next line
                        maxLines: 3, // Limit the description to 2 or 3 lines
                        overflow: TextOverflow
                            .ellipsis, // Show "..." at the end if text exceeds 3 lines
                      ),
                      const SizedBox(height: 10),
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
