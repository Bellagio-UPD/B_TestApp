import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonLabel;
  const ChoiceButton({super.key, required this.onPressed, required this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: onPressed, child: Text(buttonLabel,style: getContentTextSmall(),)),
    );
  }
}
