// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';
import 'package:popover/popover.dart';

class AdminBlogCard extends StatefulWidget {
  final String titleText;
  final String descriptionText;
  final String imageUrl;
  final DateTime madeAt;
  final List listOfLikes;
  final String idBlog;
  final String userId;

  final Function() onTap;

  const AdminBlogCard({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.imageUrl,
    required this.onTap,
    required this.madeAt,
    required this.listOfLikes,
    required this.idBlog,
    required this.userId,
  });

  @override
  State<AdminBlogCard> createState() => _AdminBlogCardState();
}

class _AdminBlogCardState extends State<AdminBlogCard> {
  int numberOfComments = 0;
  int numberOfLikes = 0;
  late UserModel userModel; // Make userModel nullable
  bool isLoading = true; // Add a loading flag

  @override
  void initState() {
    super.initState();
    initPage();
  }

  void initPage() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    userModel =
        await firestore.collection("users").doc(widget.userId).get().then((v) {
      final json = v.data();
      return UserModel.fromJson(json!);
    });
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
    isLoading = false; // Set loading to false after data is fetched
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Display a loading indicator while data is being fetched
      return const Column(
        children: [
          SizedBox(
            height: 250,
          ),
          CircularProgressIndicator(),
        ],
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Column(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: ColorsApp.greyColor,
                                        border: Border.all(
                                            color: ColorsApp.blackColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: userModel.imageUrl.isEmpty
                                            ? const Center(
                                                child: Icon(
                                                  Icons.person,
                                                  size: 45,
                                                  color: ColorsApp.whiteColor,
                                                ),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: userModel.imageUrl,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Center(
                                                  child: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userModel.userName,
                                          style: TextStyleForms.headLineStyle02,
                                        ),
                                        Text(
                                          userModel.userDescription,
                                          style: TextStyleForms.headLineStyle03,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Builder(
                                      builder: (context) {
                                        return IconButton(
                                          onPressed: () => showPopover(
                                            context: context,
                                            bodyBuilder: (context) => ItemMenu(
                                              blogModel: BlogModel(
                                                userId: widget.userId,
                                                createdAt: widget.madeAt,
                                                listOfLikes: widget.listOfLikes,
                                                id: widget.idBlog,
                                                title: widget.titleText,
                                                description:
                                                    widget.descriptionText,
                                                imageUrl: widget.imageUrl,
                                              ),
                                              userModel: userModel,
                                            ),
                                            width: 300,
                                            barrierColor: ColorsApp.blackColor
                                                .withOpacity(0.7),
                                            arrowHeight: 15,
                                            arrowWidth: 30,
                                            onPop: () => {},
                                          ),
                                          icon: const Icon(
                                            Icons.more_vert_rounded,
                                            color: ColorsApp.blueColor,
                                            size: 30,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: ColorsApp.blackColor,
                                        width: 1.5),
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
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.titleText,
                                    style: TextStyleForms.headLineStyle01,
                                    maxLines: null,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    widget.descriptionText,
                                    style: TextStyleForms.headLineStyle03,
                                    maxLines: null,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.favorite,
                                              color: ColorsApp.blueColor,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              numberOfLikes.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: ColorsApp.blackColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.comment,
                                              color: ColorsApp.blueColor,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 2),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({super.key, required this.blogModel, required this.userModel});

  final BlogModel blogModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            //! remove from BLOGS
            await FirebaseFirestore.instance
                .collection("blogs")
                .doc(blogModel.id)
                .delete();
            //! remove from REPORTED-BLOGS

            await FirebaseFirestore.instance
                .collection("reported-blogs")
                .doc(blogModel.id)
                .delete();

            Navigator.pop(context);
            CherryToast.info(
                title: Text(
              "Blog Deleted From Application.",
              style: TextStyleForms.headLineStyle03,
            )).show(context);
          },
          child: Container(
            color: ColorsApp.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.delete_rounded, size: 30, color: Colors.red),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Delete Blog",
                    style: TextStyleForms.popoberRedTileStyle02,
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          width: 150,
          color: ColorsApp.greyColor,
        ),
        GestureDetector(
          onTap: () async {
            //! BLOCK USER !!
            log(userModel.id.toString());
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userModel.id)
                .update({'isBlocked': true});

            //! remove from BLOGS
            await FirebaseFirestore.instance
                .collection("blogs")
                .doc(blogModel.id)
                .delete();
            //! remove from REPORTED-BLOGS
            await FirebaseFirestore.instance
                .collection("reported-blogs")
                .doc(blogModel.id)
                .delete();
            Navigator.pop(context);
            CherryToast.info(
                title: Text(
              "Blog Deleted From Application.",
              style: TextStyleForms.headLineStyle03,
            )).show(context);
          },
          child: Container(
            color: ColorsApp.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.block_rounded, size: 30, color: Colors.red),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Delete and Block User",
                    style: TextStyleForms.popoberRedTileStyle02,
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          width: 150,
          color: ColorsApp.greyColor,
        ),
        GestureDetector(
          onTap: () async {
            await FirebaseFirestore.instance
                .collection("reported-blogs")
                .doc(blogModel.id)
                .delete();
            Navigator.pop(context);
            CherryToast.success(
                title: Text(
              "Report Refused.",
              style: TextStyleForms.headLineStyle03,
            )).show(context);
          },
          child: Container(
            color: ColorsApp.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_rounded,
                      size: 30, color: ColorsApp.blueColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Refuse Report",
                    style: TextStyleForms.buttonBlue,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
