import 'package:flutter/material.dart';
import 'package:mustaqim/core/colors.dart';
import 'package:mustaqim/core/styles_text.dart';
import 'package:mustaqim/models/blog_model.dart';
import 'package:mustaqim/screens/blog_screen.dart';

class FavoritesCard extends StatelessWidget {
  const FavoritesCard(
      {super.key,
      required this.creatorName,
      required this.blogTitle,
      required this.blogModel});
  final String creatorName;
  final String blogTitle;
  final BlogModel blogModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: ColorsApp.blackColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  creatorName,
                  style: TextStyleForms.headLineStyle02,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return BlogScreen(
                          blogModel: blogModel,
                        );
                      },
                    ));
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: ColorsApp.blackColor, width: 2),
                        color: ColorsApp.blueColor),
                    child: const Icon(
                      Icons.remove_red_eye_rounded,
                      color: ColorsApp.whiteColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Title :",
                  style: TextStyleForms.buttonBlue1,
                ),
                Expanded(
                  child: Text(
                    blogTitle,
                    style: TextStyleForms.headLineStyle03,
                    maxLines: 100,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
