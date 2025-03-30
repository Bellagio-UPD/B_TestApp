import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_icon/gradient_icon.dart';

import '../../core/constants/app_gradients.dart';
import '../../core/constants/color_manager.dart';
import '../../core/constants/style_manager.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  const AppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: const GradientIcon(
                icon: Icons.arrow_back_ios_rounded,
                gradient: AppColors.accentColor,
                size: 24,
              ),
            ),
          ),
          SizedBox(
            width: 0,
          ),
          Gradients(
              text: title,
              style: gradientTitleTextMedium,
              gradient: AppColors.accentColor),
        ],
      ),
    );
  }
}
