import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

void showHoveringSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Expanded(
          child: Text(
            message,
            style: getLabelTextMedium(),
            textAlign: TextAlign.start,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: AppColors.textColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ],
    ),
    backgroundColor: AppColors.secondaryColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
