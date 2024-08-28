import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/screens/my_blogs_screen.dart';

class MyBlogCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;
  final DateTime madeAt;
  final String idBlog;
  final Function() deleteFunction;
  final Function() editFunction;

  const MyBlogCard({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.imageUrl,
    required this.madeAt,
    required this.idBlog,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  State<MyBlogCard> createState() => _MyBlogCardState();
}

class _MyBlogCardState extends State<MyBlogCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
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
              const SizedBox(width: 5),
              Text(
                widget.madeAt.toIso8601String().substring(0, 10),
                style: TextStyleForms.headLineStyle03,
              ),
              const SizedBox(width: 5),
              Container(
                color: ColorsApp.greyColor,
                height: 2,
                width: 100,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorsApp.CardColor,
                border: Border.all(
                  color: ColorsApp.blackColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.titleText,
                            style: TextStyleForms.headLineStyle01,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.descriptionText,
                            style: TextStyleForms.headLineStyle03,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  _showDeleteDialog(context);
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      border: Border.all(
                                          color: ColorsApp.blackColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.delete_rounded,
                                            size: 23,
                                            color: ColorsApp.whiteColor,
                                          ),
                                          Text(
                                            "Delete Blog",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: ColorsApp.whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.editFunction();
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      border: Border.all(
                                          color: ColorsApp.blackColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.edit_square,
                                            size: 23,
                                            color: ColorsApp.whiteColor,
                                          ),
                                          Text(
                                            "Edit Blog",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: ColorsApp.whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
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
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Do you want to delete this blog?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () async {
                CherryToast.success(
                  description: Text(
                    "Blog Deleted Successfully",
                    style: TextStyleForms.headLineStyle03,
                  ),
                ).show(context);

                await widget.deleteFunction(); // Call the delete function

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyBlogsScreen(),
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
