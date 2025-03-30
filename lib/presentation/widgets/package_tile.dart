import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

class PackageTile extends StatelessWidget {
  final String title;
  final String value;
  final String content;
  final bool selected;
  final VoidCallback? ontap;
   PackageTile(
      {super.key,
      required this.title,
      required this.content,
      this.selected = false,
      required this.value,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
              gradient: AppColors.accentColor,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: getTileTitleLarge(),
                    ),
                    if (selected == true)
                      const Icon(
                        Icons.verified,
                        size: 30,
                        color: AppColors.textColor,
                      )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  value,
                  style: getTilePrice(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  content,
                  style: getText(
                    fontsize: FontSizes.s14,
                    color: AppColors.contentTextColor,
                  ),
                  // overflow: TextOverflow.visible,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
