import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/favorites_card.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> blogIdsContainingUser = [];
  List<BlogModel> blogModels = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    searchBlogsForUser();
  }

  Future<void> searchBlogsForUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch all documents in the 'blogs' collection
    QuerySnapshot querySnapshot = await firestore.collection('blogs').get();

    // Loop through documents to find blogs liked by the current user
    for (var doc in querySnapshot.docs) {
      List<dynamic> listOfLikes = doc.get('listOfLikes');

      if (listOfLikes.contains(auth.currentUser!.uid)) {
        blogIdsContainingUser.add(doc.id);
      }
    }

    // Fetch BlogModel for each blog ID
    for (String blogId in blogIdsContainingUser) {
      DocumentSnapshot docSnapshot =
          await firestore.collection('blogs').doc(blogId).get();

      // Create BlogModel from the document data
      if (docSnapshot.exists) {
        BlogModel blogModel =
            BlogModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
        blogModels.add(blogModel);
      }
    }

    // Update the UI with the fetched blog models
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: ColorsApp.whiteColor,
        title: Row(
          children: [
            const Icon(
              Icons.favorite_rounded,
              size: 25,
              color: ColorsApp.blueColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Your Favorites',
              style: TextStyleForms.buttonBlue,
            ),
          ],
        ),
      ),
      body: blogModels.isEmpty
          ? const Center(child: Text('No favorites found.'))
          : ListView.builder(
              itemCount: blogModels.length,
              itemBuilder: (context, index) {
                BlogModel blog = blogModels[index];

                return FavoriteTile(blog: blog);
              },
            ),
    );
  }
}

class FavoriteTile extends StatefulWidget {
  const FavoriteTile({
    super.key,
    required this.blog,
  });

  final BlogModel blog;

  @override
  State<FavoriteTile> createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  late UserModel userModel;
  bool isPageLoading = true;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  initPage() async {
    if (isPageLoading) {
      userModel = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.blog.userId)
          .get()
          .then((v) {
        final json = v.data()!;
        return UserModel.fromJson(json);
      });
      setState(() {
        isPageLoading = false;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  color: ColorsApp.blueColor,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: FavoritesCard(
              blogModel: widget.blog,
              creatorName: userModel.userName,
              blogTitle: widget.blog.title,
            ),
          );
  }
}
