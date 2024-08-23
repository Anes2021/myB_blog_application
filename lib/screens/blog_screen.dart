// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'dart:developer';
import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/core/text_field_form.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/models/comment_model.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class BlogScreen extends StatefulWidget {
  final BlogModel blogModel;

  const BlogScreen({super.key, required this.blogModel});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final auth = FirebaseAuth.instance;

  final TextEditingController _commentController = TextEditingController();

  bool isLiked = false;
  bool isWaitingCommnet = false;
  bool isWaitingLike = false;
  bool areCommentsVisible = false;

  //* 1 variables (instance - var - bool)
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late List<CommentModel> listOfCommentsModel;
  bool isPageLoading = true;

  //* 2 intsttae
  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    setState(() {
      isPageLoading = true;
    });

    //* Initialize the list
    listOfCommentsModel = [];

    isLiked = widget.blogModel.listOfLikes.contains(auth.currentUser!.uid);

    //* Fetch the comments from Firestore
    await firestore
        .collection("blogs")
        .doc(widget.blogModel.id)
        .collection("comments")
        .orderBy("date", descending: true)
        .get()
        .then((collection) {
      List docs = collection.docs;

      //* Iterate through the documents and add them to the list
      // for (var doc in docs) {
      //   final json = doc.data();
      //   final CommentModel commentModel = CommentModel.fromJson(json);
      //   log(commentModel.toString());
      //   listOfCommentsModel.add(commentModel);
      // }

      listOfCommentsModel = docs.map((doc) {
        final json = doc.data();
        final CommentModel commentModel = CommentModel.fromJson(json);
        return commentModel;
      }).toList();

      log(listOfCommentsModel.toString()); // Check if the list is populated
    });

    //* Update the state after loading is complete
    setState(() {
      isPageLoading = false;
    });
  }

  refrehsPage() async {
    //* Initialize the list
    listOfCommentsModel = [];

    //* Fetch the comments from Firestore
    await firestore
        .collection("blogs")
        .doc(widget.blogModel.id)
        .collection("comments")
        .orderBy("date", descending: true)
        .get()
        .then((collection) {
      List docs = collection.docs;

      //* Iterate through the documents and add them to the list
      // for (var doc in docs) {
      //   final json = doc.data();
      //   final CommentModel commentModel = CommentModel.fromJson(json);
      //   log(commentModel.toString());
      //   listOfCommentsModel.add(commentModel);
      // }

      listOfCommentsModel = docs.map((doc) {
        final json = doc.data();
        final CommentModel commentModel = CommentModel.fromJson(json);
        return commentModel;
      }).toList();

      log(listOfCommentsModel.toString()); // Check if the list is populated
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        //* 4 isPageLoading
        Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.whiteColor,
        title: Text(
          widget.blogModel.title.length > 18
              ? '${widget.blogModel.title.substring(0, 18)}...'
              : widget.blogModel.title,
          style: TextStyleForms.headLineStyle01,
        ),
        centerTitle: true,
      ),
      body: isPageLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                          // Blog Content Section (Image, Title, Description)
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
                                        widget.blogModel.imageUrl,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.blogModel.title,
                                          style: TextStyleForms.headLineStyle04,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          widget.blogModel.description,
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
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // LIKE BUTTON
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: isWaitingLike
                                                      ? null
                                                      : () async {
                                                          setState(() {
                                                            isWaitingLike =
                                                                true;
                                                          });
                                                          final String userId =
                                                              auth.currentUser!
                                                                  .uid;

                                                          List newListOfLikes =
                                                              widget.blogModel
                                                                  .listOfLikes;

                                                          if (isLiked) {
                                                            // unLike
                                                            newListOfLikes
                                                                .remove(userId);
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "blogs")
                                                                .doc(widget
                                                                    .blogModel
                                                                    .id)
                                                                .update({
                                                              "listOfLikes":
                                                                  newListOfLikes
                                                            });
                                                          } else {
                                                            // like

                                                            newListOfLikes
                                                                .add(userId);
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "blogs")
                                                                .doc(widget
                                                                    .blogModel
                                                                    .id)
                                                                .update({
                                                              "listOfLikes":
                                                                  newListOfLikes
                                                            });
                                                          }

                                                          setState(() {
                                                            isLiked = !isLiked;
                                                            isWaitingLike =
                                                                false;
                                                          });
                                                        },
                                                  icon: Icon(
                                                    isLiked
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    size: 37,
                                                    color: ColorsApp.greyColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                // fetch widget.blogModel.imageUrl ====)) File()

                                                await shareImageFromFirebase(
                                                    widget.blogModel.imageUrl);
                                              },
                                              icon: Icon(
                                                Icons.share,
                                                size: 37,
                                                color: ColorsApp.greyColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  areCommentsVisible =
                                                      !areCommentsVisible;
                                                });
                                              },
                                              icon: Icon(
                                                areCommentsVisible
                                                    ? Icons.comment
                                                    : Icons.comment_outlined,
                                                size: 37,
                                                color: ColorsApp.greyColor,
                                              ),
                                            ),
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
                          const SizedBox(height: 10),

                          // Section to Add Your Comment
                          !areCommentsVisible
                              ? Container()
                              : Column(
                                  children: [
                                    TextFieldForm(
                                      textEditingController: _commentController,
                                      labelT: "Type Your Comment",
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: isWaitingCommnet
                                          ? null
                                          : () async {
                                              await _comment();
                                            },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorsApp.blackColor
                                                    .withOpacity(
                                                        0.3), // Shadow color with opacity
                                                spreadRadius:
                                                    5.0, // Spread radius of the shadow
                                                blurRadius:
                                                    10.0, // Blur radius of the shadow
                                                offset: const Offset(0,
                                                    4), // Offset of the shadow (horizontal, vertical)
                                              ),
                                            ],
                                            border: Border.all(
                                                color: ColorsApp.blackColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color(0XFF4258E1)),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                isWaitingCommnet
                                                    ? "WAIT.."
                                                    : "Submit Comment",
                                                style:
                                                    TextStyleForms.buttonStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),

                          // Section to View Other People's Comments
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listOfCommentsModel.length,
                            itemBuilder: (context, index) {
                              return CommentCard(
                                commentModel: listOfCommentsModel[index],
                              );
                            },
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

  Future _comment() async {
    setState(() {
      isWaitingCommnet = true;
    });

    //! validtaion
    if (_commentController.text.trim().isEmpty) {
      CherryToast.error(
        description: const Text("PLEASE WRITE SOMETHING"),
      ).show(context);
      setState(() {
        isWaitingCommnet = false;
      });
      return;
    }

    //* start

    //* read user name

    final UserModel userModel = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((doc) {
      final json = doc.data();
      return UserModel.fromJson(json!);
    });

    final String id = const Uuid().v4();

    final CommentModel commentModel = CommentModel(
      date: DateTime.now(),
      id: id,
      userId: auth.currentUser!.uid,
      username: userModel.userName,
      description: _commentController.text.trim(),
    );

    await firestore
        .collection("blogs")
        .doc(widget.blogModel.id)
        .collection("comments")
        .doc(commentModel.id) //
        .set(commentModel.toJson());

    //* finilize
    _commentController.clear();

    //*

    CherryToast.success(
      description: Text("comment add successfuly"),
    ).show(context);

    //* end
    setState(() {
      isWaitingCommnet = false;
    });

    refrehsPage();
  }
}

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,
    required this.commentModel,
  });

  final CommentModel commentModel;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.commentModel.username,
                      style: TextStyleForms.headLineStyle02,
                    ),
                    Spacer(),
                    Text(
                      widget.commentModel.date
                          .toIso8601String()
                          .substring(0, 10),
                      style: TextStyleForms.headLineStyle03,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(widget.commentModel.description,
                    style: TextStyleForms.headLineStyle03),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

Future<void> shareImageFromFirebase(String imageUrl) async {
  try {
    // 1. Get a reference to the file from Firebase Storage
    final ref = FirebaseStorage.instance.refFromURL(imageUrl);

    // 2. Download the file to a temporary directory
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/tempImage.png';
    final File tempFile = File(tempPath);

    await ref.writeToFile(tempFile);

    // 3. Share the image using share_plus package
    Share.shareXFiles([XFile(tempFile.path)], text: 'Check out this image!');
  } catch (e) {
    print('Error sharing image: $e');
  }
}
