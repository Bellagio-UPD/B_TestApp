import 'dart:convert';

import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../core/constants/color_manager.dart';

class LoyaltyCard extends StatelessWidget {
  final String cardName;
  final String image;
  final double bellagioPoints;
  final double totalPoints;
  final double? bottomLine;
  final String activatedDate;
  final VoidCallback onTap;
  final double? otp;
  final double? percentage;
  final String? username;
  final String? bellagioId;
  const LoyaltyCard(
      {super.key,
      required this.cardName,
      required this.bellagioPoints,
      required this.totalPoints,
      required this.activatedDate,
      required this.image,
      required this.onTap,
      this.bottomLine,
      this.otp,
      this.percentage,
      this.username,
      this.bellagioId});

  double _percentage(double topline, double points) {
    double percent = points / topline;

    if (percent < 1) {
      return percent;
    } else {
      return percent = 100.0;
    }
  }

  String _decodeBellagioId(String bellagioId) {
    String decodedId = utf8.decode(base64.decode(bellagioId));
    return decodedId;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.tileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gradients(
                  text: cardName,
                  style: gradientContentTextMedium,
                  gradient: AppColors.accentColor),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(alignment: AlignmentDirectional(-0.8, 0.8), children: [
                    Image.asset(
                      image,
                      width: MediaQuery.of(context).size.width * 0.44,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username ?? '',
                          style: getLoyaltyCardUsername(),
                        ),
                        Text(
                          _decodeBellagioId(bellagioId ?? ''),
                          style: getLoyaltyCardUsername(),
                        ),
                      ],
                    ),
                  ]),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      children: [
                        Gradients(
                          gradient: AppColors.accentColor,
                          text: otp?.toInt().toString() ?? "0",
                          style: gradientContentTextLarge,
                        ),
                        Text(
                          "OTP",
                          style: getContentTextMedium(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 8.0,
                animationDuration: 2000,
                percent: _percentage(
                    totalPoints.toDouble(), bellagioPoints.toDouble()),
                padding: EdgeInsets.symmetric(horizontal: 0),
                backgroundColor: AppColors.secondaryColor,
                linearStrokeCap: LinearStrokeCap.roundAll,
                barRadius: Radius.circular(10),
                linearGradient: LinearGradient(colors: [
                  AppColors.gold1,
                  AppColors.gold2,
                  AppColors.gold1
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // NumberFormat.
                    bottomLine?.toInt().toString() ?? '',
                    style: getContentTextSmall(),
                  ),
                  Row(
                    children: [
                      Gradients(
                        gradient: AppColors.accentColor,
                        text: "${bellagioPoints.toInt()}",
                        style: gradientLoyaltyCardPoints,
                      ),
                      Text(
                        totalPoints >= 9999999
                            ? '/\u221E'
                            : '/${totalPoints.toInt().toString()}',
                        style: getContentTextSmall(),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Play, earn points & level up! Every game gets you closer to the next tier.",
                style: getDateTimeLabel(),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
