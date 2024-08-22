// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/blog_card.dart';
import 'package:mustaqim/core/button_form.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/screens/auth/login_screen.dart';
import 'package:mustaqim/screens/blog_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<BlogModel> listOfBlogs;
  bool isPageLoading = true;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    setState(() {
      isPageLoading = true;
    });
    final firebase = FirebaseFirestore.instance;

    await firebase
        .collection("blogs")
        .orderBy("createdAt", descending: false)
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: ColorsApp.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: ColorsApp.whiteColor),
                        child: const Center(
                          child: Icon(
                            Icons.language_rounded,
                            size: 25,
                            color: ColorsApp.blueColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        'assets/images/app_icon_scaled.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();

                        CherryToast.success(
                          description: const Text("SIGNED OUT SUCCESSFULLY!"),
                        ).show(context);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: ColorsApp.whiteColor),
                        child: const Center(
                          child: Icon(
                            Icons.exit_to_app_rounded,
                            size: 25,
                            color: ColorsApp.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorsApp.blueColor,
            ),
          ),
          isPageLoading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: listOfBlogs.length,
                    itemBuilder: (context, index) {
                      return BlogCard(
                        titleText: listOfBlogs[index].title, //
                        descriptionText: listOfBlogs[index].description.trim(),
                        imageUrl: listOfBlogs[index].imageUrl.trim(),
                        onTap: () {
                          //
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlogScreen(
                              blogModel: listOfBlogs[index],
                            ),
                          ));
                          //
                        },
                      );
                    },
                  ),
                ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 3,
                color: ColorsApp.blueColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: ColorsApp.whiteColor,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ButtonForm(
                      buttonT: "Create Blog",
                      function: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
