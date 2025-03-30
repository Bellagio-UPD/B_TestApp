import 'package:flutter/material.dart';

class SocialsButtons extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  const SocialsButtons({
    super.key,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ));
  }
}
