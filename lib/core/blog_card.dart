// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';

class BlogCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;
  final DateTime madeAt;
  final List listOfLikes;
  final String idBlog;

  final Function() onTap;

  const BlogCard({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.imageUrl,
    required this.onTap,
    required this.madeAt,
    required this.listOfLikes,
    required this.idBlog,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  int numberOfComments = 0;
  int numberOfLikes = 0;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    numberOfComments = await firestore
        .collection("blogs")
        .doc(widget.idBlog)
        .collection("comments")
        .get()
        .then(
      (v) {
        return v.docs.length;
      },
    );
    numberOfLikes = widget.listOfLikes.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 20,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: ColorsApp.greyColor,
                  height: 2,
                  width: 100,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.madeAt.toIso8601String().substring(0, 10),
                  style: TextStyleForms.headLineStyle03,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  color: ColorsApp.greyColor,
                  height: 2,
                  width: 100,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                bottom: 10.0, top: 10.0), // Space between each card
            child: Material(
              elevation: 5.0, // Adjust elevation as needed
              borderRadius: BorderRadius.circular(
                  30), // Match with Container's borderRadius
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorsApp.CardColor,
                  border: Border.all(
                    color: ColorsApp.blackColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(
                      30), // Adjust the radius value as needed
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
                              border: Border.all(
                                  color: ColorsApp.blackColor, width: 1.5),
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
                              maxLines:
                                  3, // Limit the description to 2 or 3 lines
                              overflow: TextOverflow
                                  .ellipsis, // Show "..." at the end if text exceeds 3 lines
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        color: ColorsApp.blueColor,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        numberOfLikes.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: ColorsApp.blackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 0020,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.comment,
                                        color: ColorsApp.blueColor,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        numberOfComments.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: ColorsApp.blackColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
