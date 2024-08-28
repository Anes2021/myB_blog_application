import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/my_blog_card.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';

class MyBlogsScreen extends StatefulWidget {
  const MyBlogsScreen({super.key});

  @override
  State<MyBlogsScreen> createState() => _MyBlogsScreenState();
}

class _MyBlogsScreenState extends State<MyBlogsScreen> {
  List<BlogModel> blogModels = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  Future<void> initPage() async {
    QuerySnapshot querySnapshot = await firestore
        .collection("blogs")
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get();

    blogModels = querySnapshot.docs.map((doc) {
      return BlogModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    setState(() {});
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
      body: blogModels.isEmpty
          ? Center(
              child: Text(
                "This Page is Empty.",
                style: TextStyleForms.headLineStyle03,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: blogModels.length,
              itemBuilder: (context, index) {
                final blog = blogModels[index];

                return MyBlogCard(
                  editFunction: () => _showEditBlogBottomSheet(context, blog),
                  titleText: blog.title,
                  descriptionText: blog.description,
                  imageUrl: blog.imageUrl,
                  madeAt: blog.createdAt,
                  idBlog: blog.id,
                  deleteFunction: () async {
                    await firestore.collection("blogs").doc(blog.id).delete();
                    initPage();
                  },
                );
              },
            ),
    );
  }

  void _showEditBlogBottomSheet(BuildContext context, BlogModel blog) {
    final TextEditingController titleController =
        TextEditingController(text: blog.title);
    final TextEditingController descriptionController =
        TextEditingController(text: blog.description);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Blog',
                style: TextStyleForms.headLineStyle01,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Blog Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Blog Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await firestore.collection("blogs").doc(blog.id).update({
                        'title': titleController.text,
                        'description': descriptionController.text,
                      });
                      Navigator.of(context).pop(); // Close the bottom sheet
                      setState(() {
                        // Update local blog model with new data
                        blog.title = titleController.text;
                        blog.description = descriptionController.text;
                      });
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
