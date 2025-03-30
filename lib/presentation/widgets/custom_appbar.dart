import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_icon/gradient_icon.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon? icon;
  final Actions? action;
  final double toolBarHeight;
  final bool showLeadingIcon;
  final bool actions;
  final String? label;
  final VoidCallback? onPressed;

  const CustomAppbar({
    super.key,
    required this.title,
    this.icon,
    this.action,
    this.toolBarHeight = 100,
    this.showLeadingIcon = true,
    this.actions = false,
    this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.navbarColor,
      toolbarHeight: toolBarHeight,
      centerTitle: false,
      leadingWidth:
          showLeadingIcon ? 50 : 0, // Increased width for better tap area
      leading: showLeadingIcon
          ? Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                behavior: HitTestBehavior
                    .opaque, // Ensures taps are detected even outside the icon
                onTap: () => GoRouter.of(context).pop(),
                child: Container(
                  alignment: Alignment.center,
                  width: 50, // Increased tappable area
                  height: 50,
                  child: const GradientIcon(
                    icon: Icons.arrow_back_ios_rounded,
                    gradient: AppColors.accentColor,
                    size: 30,
                  ),
                ),
              ),
            )
          : const SizedBox
              .shrink(), // Prevents default back button when `false`
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10),
        child: Gradients(
          text: title,
          style: gradientTitleTextMedium,
          gradient: AppColors.accentColor,
        ),
      ),
      actions: actions
          ? <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 25.0),
                  child: TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      label ?? "",
                      style: getLabelTextMedium(),
                    ),
                  ),
                ),
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight);
}
