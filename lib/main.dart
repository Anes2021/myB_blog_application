import 'package:flutter/material.dart';
import 'package:mustaqim/screens/create_blog_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateBlogScreen();
  }
}
