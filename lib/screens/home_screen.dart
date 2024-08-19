import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/core/blog_card.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/screens/create_blog_screen.dart';

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

    await firebase.collection("blogs").get().then((collection) {
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
  Widget build(BuildContext context) => MaterialApp(
        // Define your custom text theme here

        home: Scaffold(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 70,
                          width: 70,
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.asset(
                            'assets/images/app_icon_scaled.png',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: ColorsApp.whiteColor),
                            child: const Center(
                              child: Icon(
                                Icons.exit_to_app_rounded,
                                size: 25,
                                color: ColorsApp.blackColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                          width: 10,
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
                            titleText: listOfBlogs[index].title,
                            descriptionText: listOfBlogs[index].title,
                            imageUrl: listOfBlogs[index].imageUrl,
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
                    child: Center(
                        child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorsApp.blackColor, width: 2),
                          color: ColorsApp.blueColor,
                          borderRadius: BorderRadius.circular(30)),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
