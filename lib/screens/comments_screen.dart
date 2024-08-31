// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/models/comment_model.dart';
import 'package:mustaqim/screens/blog_screen.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => FfavoritesScreenState();
}

class FfavoritesScreenState extends State<CommentsScreen> {
  late List<CommentModel> listOfCommentedBlogs = [];
  late CommentModel commentModel;
  late String blogId;

  bool isDeleting = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getCommentsByUser();
    super.initState();
  }

  getCommentsByUser() async {
    final firestore = FirebaseFirestore.instance;
    listOfCommentedBlogs = [];

    // Fetch all blog documents
    QuerySnapshot blogSnapshot = await firestore.collection('blogs').get();

    // Loop through each blog document
    for (var blogDoc in blogSnapshot.docs) {
      // Query comments subcollection where authorId matches the userId
      QuerySnapshot commentSnapshot = await firestore
          .collection('blogs')
          .doc(blogDoc.id)
          .collection('comments')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Convert the documents into CommentModel instances and add to the list
      for (var commentDoc in commentSnapshot.docs) {
        listOfCommentedBlogs.add(
            CommentModel.fromJson(commentDoc.data() as Map<String, dynamic>));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getCommentsByUser();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.comment_rounded,
                      size: 21, color: ColorsApp.blueColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Comments",
                    style: TextStyleForms.buttonBlue,
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: ColorsApp.whiteColor,
        ),
        body: listOfCommentedBlogs.isEmpty
            ? Center(
                child: Text(
                  "NO COMMENTS",
                  style: TextStyleForms.buttonBlue,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: listOfCommentedBlogs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorsApp.blackColor, width: 2),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listOfCommentedBlogs[index].username,
                                    style: TextStyleForms.headLineStyle02,
                                  ),
                                  Text(
                                    listOfCommentedBlogs[index]
                                        .date
                                        .toIso8601String()
                                        .substring(0, 10),
                                    style: TextStyleForms.headLineStyle03,
                                  ),
                                  GestureDetector(
                                    onTap: isDeleting
                                        ? null
                                        : () async {
                                            setState(() {
                                              isDeleting = true;
                                            });

                                            await FirebaseFirestore.instance
                                                .collection("blogs")
                                                .doc(listOfCommentedBlogs[index]
                                                    .blogId)
                                                .collection("comments")
                                                .doc(listOfCommentedBlogs[index]
                                                    .id)
                                                .delete();
                                            await getCommentsByUser();
                                            setState(() {
                                              isDeleting = false;
                                            });
                                          },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorsApp.blackColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red),
                                      child: const Icon(
                                        Icons.delete_rounded,
                                        color: ColorsApp.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(listOfCommentedBlogs[index].description,
                                      style: TextStyleForms.headLineStyle03),
                                  GestureDetector(
                                    onTap: () async {
                                      log("wdqsdqs");
                                      final blogModel = await firestore
                                          .collection("blogs")
                                          .doc(listOfCommentedBlogs[index]
                                              .blogId)
                                          .get()
                                          .then((v) {
                                        return BlogModel.fromJson(v.data()!);
                                      });

                                      log(blogModel.toString());

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return BlogScreen(
                                            blogModel: blogModel,
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorsApp.blackColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorsApp.blueColor),
                                      child: const Icon(
                                        Icons.remove_red_eye,
                                        color: ColorsApp.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
