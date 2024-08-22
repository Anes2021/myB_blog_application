import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';
import 'package:mustaqim/screens/create_blog_screen.dart';
import 'package:mustaqim/screens/home_screen.dart'; // Your registration screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'home': (context) => const HomeScreen(),
        'createBlog': (context) => const CreateBlogScreen(),
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // Listen to auth state changes
        builder: (context, snapshot) {
          // If snapshot has data, the user is signed in
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return const SignUpScreen(); // Redirect to sign-up (or login) screen if not signed in
            } else {
              return const HomeScreen(); // Redirect to home screen if signed in
            }
          }
          // While waiting for connection, show a loading indicator
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
