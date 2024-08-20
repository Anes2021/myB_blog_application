import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/screens/create_blog_screen.dart';

class BlogScreen extends StatelessWidget {
  final BlogModel blogModel;

  const BlogScreen({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.whiteColor,
        title: Text(
          blogModel.title.length > 18
              ? '${blogModel.title.substring(0, 18)}...'
              : blogModel.title,
          style: TextStyleForms.headLineStyle01,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 3,
            decoration: const BoxDecoration(color: ColorsApp.blueColor),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorsApp.blackColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  blogModel.imageUrl,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    blogModel.title,
                                    style: TextStyleForms.headLineStyle04,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    blogModel.description,
                                    style: TextStyleForms.headLineStyle03,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      //? LIKE BUTTON
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_up_sharp,
                                            size: 37,
                                            color: ColorsApp.greyColor,
                                          ),
                                          // Text(
                                          //   " : ",
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       color: ColorsApp.greyColor,
                                          //       fontSize: 37),
                                          // ),
                                          // Text(
                                          //   "21",
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       color: ColorsApp.greyColor,
                                          //       fontSize: 37),
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.comment_sharp,
                                            size: 37,
                                            color: ColorsApp.greyColor,
                                          ),
                                          // Text(
                                          //   " : ",
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       color: ColorsApp.greyColor,
                                          //       fontSize: 37),
                                          // ),
                                          // Text(
                                          //   "21",
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       color: ColorsApp.greyColor,
                                          //       fontSize: 37),
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.share_sharp,
                                            size: 37,
                                            color: ColorsApp.greyColor,
                                          ),
                                          // SizedBox(
                                          //   width: 20,
                                          // )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
