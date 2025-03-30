import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';

class AirTicketCard extends StatelessWidget {
  final String departureCountry;
  final String arrivalCountry;
  final String departure;
  final String arrival;
  final String departureTime;
  final String arrivalTime;
  final String departureDate;
  final String arrivalDate;
  final String flyingHours;
  final String flightClass;
  final int amount;
  final String? flightType;
  final VoidCallback onTap;
  final String airline;
  const AirTicketCard(
      {super.key,
      required this.onTap,
      required this.departureCountry,
      required this.arrivalCountry,
      required this.departure,
      required this.arrival,
      required this.departureTime,
      required this.arrivalTime,
      required this.departureDate,
      required this.arrivalDate,
      required this.flyingHours,
      required this.flightClass,
      required this.amount,
      this.flightType,
      required this.airline});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(height: 60, width: 100, image: AssetImage(airline)),
                SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       departureCountry,
                //       style: getAirTicketContentMedium(),
                //     ),
                //     Text(
                //       arrivalCountry,
                //       style: getAirTicketContentMedium(),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      departure,
                      style: getAirTicketTitleLarge(),
                    ),
                    Image(
                        height: 20,
                        image: AssetImage('assets/images/destination.png')),
                    Text(
                      arrival,
                      style: getAirTicketTitleLarge(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      departureDate,
                      style: getAirTicketContentMedium(),
                    ),
                    Text(
                      arrivalDate,
                      style: getAirTicketContentMedium(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      departureTime,
                      style: getAirTicketContentMedium(),
                    ),
                    Text(
                      arrivalTime,
                      style: getAirTicketContentMedium(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      flightClass,
                      style: getLabelTextMedium(),
                    ),
                    Text(
                      "\$ ${amount}",
                      style: getLabelTextLarge(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
