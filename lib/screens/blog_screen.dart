import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';

class BlogScreen extends StatefulWidget {
  final BlogModel blogModel;

  const BlogScreen({super.key, required this.blogModel});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool isLiked = false;
  bool isWaitingLike = false;
  @override
  void initState() {
    initPage();
    super.initState();
  }

  initPage() async {
    final String deviceId = await _getDeviceId();
    // final String deviceId = auth.currentUser!.uid;

    isLiked = widget.blogModel.listOfLikes.contains(deviceId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  widget.blogModel.imageUrl,
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
                                      //? LIKE BUTTON
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: isWaitingLike
                                                ? null
                                                : () async {
                                                    setState(() {
                                                      isWaitingLike = true;
                                                    });
                                                    final String deviceId =
                                                        await _getDeviceId();

                                                    List listOfLikes = widget
                                                        .blogModel.listOfLikes;

                                                    if (isLiked) {
                                                      // unLike
                                                      listOfLikes
                                                          .remove(deviceId);
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("blogs")
                                                          .doc(widget
                                                              .blogModel.id)
                                                          .update({
                                                        "listOfLikes":
                                                            listOfLikes
                                                      });
                                                    } else {
                                                      // like

                                                      listOfLikes.add(deviceId);
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("blogs")
                                                          .doc(widget
                                                              .blogModel.id)
                                                          .update({
                                                        "listOfLikes":
                                                            listOfLikes
                                                      });
                                                    }

                                                    setState(() {
                                                      isLiked = !isLiked;
                                                      isWaitingLike = false;
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
                                      const Row(
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
                                      const Row(
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

Future<String> _getDeviceId() async {
  return "androidInfo.id";
}
