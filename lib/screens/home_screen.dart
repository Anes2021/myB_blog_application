import 'package:flutter/material.dart';
import 'package:mustaqim/core/blog_card.dart';
import 'package:mustaqim/core/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<String> _items = [];
  @override
  void initState() {
    super.initState();
    // Initialize with some data
    _items.addAll(List.generate(0, (index) => 'Item $index'));
  }

  void _addCard() {
    setState(() {
      final newIndex = _items.length;
      _items.add('Item $newIndex');
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
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return const BlogCard(
                      titleText: "Title",
                      DescriptionText:
                          "This is description . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .",
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _addCard,
                  child: const Text('Add Card'),
                ),
              ),
            ],
          ),
        ),
      );
}
