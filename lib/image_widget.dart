import 'package:flutter/material.dart';

class ImaageWidget extends StatelessWidget {
  final int index;

  const ImaageWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          child: Container(
            child: const Text("data"),
          ),
        ),
      );
}
