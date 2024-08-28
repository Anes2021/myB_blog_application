import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/admin_blog_card.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/screens/blog_screen.dart';

class AdminBlogsScreen extends StatefulWidget {
  const AdminBlogsScreen({super.key});

  @override
  State<AdminBlogsScreen> createState() => _AdminBlogsScreenState();
}

class _AdminBlogsScreenState extends State<AdminBlogsScreen> {
  List<BlogModel> listOfBlogs = [];
  bool isPageLoading = true;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  void initPage() async {
    setState(() {
      isPageLoading = true;
    });

    await firestore
        .collection("reported-blogs")
        .orderBy("createdAt", descending: true)
        .get()
        .then((collection) {
      final lsitOfDocs = collection.docs;
      final listOfJson = lsitOfDocs.map((doc) {
        return doc.data();
      });

      listOfBlogs = listOfJson.map((json) {
        return BlogModel.fromJson(json);
      }).toList();
    });

    setState(() {
      isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.photo_camera_back_rounded,
                size: 21, color: ColorsApp.blueColor),
            const SizedBox(width: 10),
            Text(
              "My Blogs",
              style: TextStyleForms.buttonBlue,
            ),
          ],
        ),
        backgroundColor: ColorsApp.whiteColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: listOfBlogs.length,
        itemBuilder: (context, index) {
          return AdminBlogCard(
            userId: listOfBlogs[index].userId,
            idBlog: listOfBlogs[index].id,
            madeAt: listOfBlogs[index].createdAt,
            titleText: listOfBlogs[index].title,
            descriptionText: listOfBlogs[index].description.trim(),
            imageUrl: listOfBlogs[index].imageUrl.trim(),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlogScreen(
                    blogModel: listOfBlogs[index],
                  ),
                ),
              );
            },
            listOfLikes: listOfBlogs[index].listOfLikes,
          );
        },
      ),
    );
  }
}
