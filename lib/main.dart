import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mustaqim/screens/auth/login_screen.dart';
import 'package:mustaqim/screens/auth/registration_screen.dart';
import 'package:mustaqim/screens/create_blog_screen.dart';
import 'package:mustaqim/screens/home_screen.dart'; // Your registration screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isPageLoading = true;
  late bool isBlocked;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  initPage() async {
    // SystemChrome.setEnabledSystemUIMode(overlays: [OverLay.i]);

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      isBlocked = true;
    } else {
      String uid = user.uid;
      isBlocked = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((doc) {
        final json = doc.data();
        setState(() {
          isPageLoading = false;
        });
        return UserModel.fromJson(json!).isBlocked;
      });
    }

    log(isBlocked.toString());
    setState(() {
      isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
          brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black),
      theme: ThemeData(
          brightness: Brightness.light,
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.grey.shade200),
      routes: {
        'home': (context) => const HomeScreen(),
        'createBlog': (context) => const CreateBlogScreen(),
      },
      home: isPageLoading
          ? Container()
          : StreamBuilder<User?>(
              stream: FirebaseAuth.instance
                  .authStateChanges(), // Listen to auth state changes
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                // If snapshot has data, the user is signed in
                final User? user = snapshot.data;
                if (user == null) {
                  return const SignUpScreen(); // Redirect to sign-up (or login) screen if not signed in
                }

                if (!isBlocked) {
                  return const HomeScreen(); // Redirect to home screen if signed in
                } else {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("YOUR ARE CURRENTLY BLOCKED FROM THE APP"),
                          const SizedBox(),
                          ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ));
                              },
                              child: const Text("change account"))
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
