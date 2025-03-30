import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

class CustomTabbar extends StatelessWidget {
  final String title;
  final int count;

  const CustomTabbar({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          count > 0
              ? Container(
                  margin: const EdgeInsetsDirectional.only(start: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: AppColors.secondaryColor, shape: BoxShape.circle),
                  child: Center(
                    child: Text(count > 9 ? "9+" : count.toString(),
                        style: getContentTextSmall()),
                  ),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                )
        ],
      ),
    );
  }
}
