import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../core/constants/style_manager.dart';

class CustomBorderButton extends StatelessWidget {
  final String? image;
  final String? buttonLabel;
  final String title;
  final bool showButton;
  final double? height;
  final VoidCallback onPressed;
  const CustomBorderButton(
      {super.key,
      this.image,
      this.buttonLabel,
      required this.title,
      this.showButton = true,
      this.height = 50,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const GradientBoxBorder(
          gradient: AppColors.accentColor,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (image != null)
            Image.asset(
              image!,
              fit: BoxFit.contain, // Constrain the image
              height: !showButton
                  ? 50
                  : height, // Provide a fixed height to avoid overflow
            ),
          const SizedBox(
            height: 10,
          ),
          Gradients(
            gradient: AppColors.accentColor,
            style: gradientContentTextMedium,
            text: title,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 10,
          ),
          if (showButton != false)
            PrimaryButton(
                label: buttonLabel ?? "Redeem",
                onPressed: onPressed,
                buttonStyleType: ButtonStyleType.filledSmall),
        ]),
      ),
    );
  }
}

class EntertainmentTile extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final bool hasImage;
  const EntertainmentTile(
      {super.key, required this.image, required this.onPressed, this.hasImage = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // border: GradientBoxBorder(
            //   gradient: AppColors.accentColor,
            //   width: 2,
            // ),
            image:
                DecorationImage(image: hasImage ? NetworkImage(image) : AssetImage(image), fit: BoxFit.fill)),
      ),
    );
  }
}
