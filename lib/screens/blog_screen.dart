import 'package:flutter/material.dart';
import 'package:mustaqim/screens/create_blog_screen.dart';

class BlogScreen extends StatelessWidget {
  final BlogModel blogModel;

  const BlogScreen({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogModel.title),
        centerTitle: true,
      ),
      //
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //$
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                blogModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    blogModel.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    blogModel.description,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
