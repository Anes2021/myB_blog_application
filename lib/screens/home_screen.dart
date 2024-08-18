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
                      titleText:
                          "I study pharmacy right now and i fell good to learn something new!",
                      DescriptionText:
                          "Discover the world of pharmacy, where science meets healthcare. Learn about the crucial role pharmacists play in ensuring safe and effective medication use, from prescription to patient care. Dive into the history, innovations, and the importance of pharmacies in our daily lives",
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
// ElevatedButton(
//                   onPressed: _addCard,
//                   child: const Text('Add Card'),
