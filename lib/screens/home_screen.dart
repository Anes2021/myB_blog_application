import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ColorsApp.mainColor1,
                expandedHeight: 200,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/images/masjed.jpg',
                    fit: BoxFit.cover,
                  ),
                  title: const Text('Flexible Title'),
                  centerTitle: true,
                ),
                //title: Text('My App Bar'),
                leading: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.message_outlined,
                      color: ColorsApp.mainColor2,
                    ),
                  ],
                ),
                actions: [
                  Container(
                    decoration:
                        const BoxDecoration(color: ColorsApp.mainColor2),
                    child: const Text("Text"),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  const Icon(
                    Icons.message_outlined,
                    color: ColorsApp.mainColor2,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.message_outlined,
                    color: ColorsApp.mainColor2,
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              buildImages(),
            ],
          ),
        ),
      );

  Widget buildImages() => SliverToBoxAdapter(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          primary: false,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) => ImaageWidget(index: index),
        ),
      );
}
