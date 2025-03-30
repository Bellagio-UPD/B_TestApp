import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

class TransactionsTile extends StatelessWidget {
  final String type;
  final String amount;
  final String? time;
  final String date;
  final String? currency;
  const TransactionsTile(
      {super.key,
      this.currency,
      required this.type,
      required this.amount,
      this.time,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        //  height: MediaQuery.of(context).size.height * 0.26,
        //   width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: AppColors.tileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColors.tileColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                    color: AppColors.secondaryColor,
                    type == "Deposit"
                        ? Icons.arrow_downward_outlined
                        : Icons.arrow_outward_sharp),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          type,
                          style: getContentTextLarge(),
                        ),
                        Text(
                          amount,
                          style: getContentTextLarge(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          time ?? '',
                          style: getDateTimeLabel(),
                        ),
                        Text(
                          date,
                          style: getDateTimeLabel(),
                        )
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
