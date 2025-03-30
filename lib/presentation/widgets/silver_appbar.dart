import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_icon/gradient_icon.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final Icon? icon;
  final double toolBarHeight;
  final bool showLeadingIcon;
  final bool actions;
  final String? label;
  final VoidCallback? onPressed;

  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.icon,
    this.toolBarHeight = 120,
    this.showLeadingIcon = true,
    this.actions = false,
    this.onPressed,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: toolBarHeight,
      floating: true,
      pinned: true,
      leading: showLeadingIcon
          ? IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: const GradientIcon(
                icon: Icons.arrow_back_ios_rounded,
                gradient: AppColors.accentColor,
                size: 25,
              ),
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
        title: Gradients(
          text: title,
          style: gradientTitleTextMedium,
          gradient: AppColors.accentColor,
        ),
      ),
      actions: actions
          ? <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.tileColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      label ?? "",
                      style: getTextfieldLabel(),
                    ),
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}
