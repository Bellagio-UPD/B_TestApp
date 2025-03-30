import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

class LoyaltyCardsSlider extends StatelessWidget {
  final String image, title;
  final int earnedPoints, totalPoints;
  final bool status;
  final String? description;
  const LoyaltyCardsSlider(
      {super.key,
      required this.image,
      required this.title,
      required this.status,
      this.description,
      // required this.activatedOn,
      required this.earnedPoints,
      required this.totalPoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.tileColor, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Gradients(
              gradient: AppColors.accentColor,
              text: title,
              style: gradientContentTextLarge,
            ),
            SizedBox(
              height: 20,
            ),
            Image(image: AssetImage(image)),
            SizedBox(
              height: 10,
            ),

            // Text(
            //   status.toString(),
            //   style: getContentTextSmall(),
            // ),
            Text(
              description ?? '',
              style: getContentTextMedium(),
              textAlign: TextAlign.justify,
            ),
            // Gradients(
            //   align: TextAlign.justify,
            //   gradient: AppColors.accentColor,
            //   text: description ?? '',
            //   style: gradientLoyaltyCardDescription,
            // ),
            SizedBox(
              height: 30,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Activated on",
            //       style: getContentTextLarge(),
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Text(
            //       activatedOn,
            //       style: getText(
            //           fontsize: FontSizes.s16, color: AppColors.dateTimeColor),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Earned points",
                  style: getContentTextLarge(),
                ),
                Gradients(
                  gradient: AppColors.accentColor,
                  text: earnedPoints.toString(),
                  style: gradientContentTextMedium,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total points",
                  style: getContentTextLarge(),
                ),
                Gradients(
                  gradient: AppColors.accentColor,
                  text: totalPoints >= 9999999
                      ? '\u221E'
                      : totalPoints.toInt().toString(),
                  style: gradientContentTextMedium,
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
