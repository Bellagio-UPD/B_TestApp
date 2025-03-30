import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

class GiftOptionsTile extends StatelessWidget {
  final String option;
  final String validity;
  final String location;
    final VoidCallback onPressed;
  const GiftOptionsTile(
      {super.key,
      required this.option,
      required this.validity,
      required this.location,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.tileColor, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: getContentTextLarge(),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location,
                          style: getContentTextMedium(),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Valid till: ${validity}",
                                style: getDateTimeLabel(),
                              ),
                              PrimaryButton(
                                  label: "Redeem",
                                  onPressed: onPressed,
                                  buttonStyleType: ButtonStyleType.filledSmall)
                            ]),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
