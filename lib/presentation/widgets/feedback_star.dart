import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackStar extends StatelessWidget {
  const FeedbackStar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      icon: const Icon(Icons.star_purple500_outlined),
    );
  }
}