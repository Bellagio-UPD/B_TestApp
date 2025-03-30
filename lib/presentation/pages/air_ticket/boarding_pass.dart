import 'package:bellagio_mobile_user/presentation/pages/air_ticket/air_tickets_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';
import '../../../data/models/air_tickets_model/air_tickets_model.dart';

class BoardingPassCard extends StatelessWidget {
  final AirTicketModel airTicketModel;
  const BoardingPassCard({super.key, required this.airTicketModel});

  String formatDate(String? date) {
    if (date == null || date == "") return "";
    DateTime parsedDate = DateTime.parse(date).toLocal();
    String dayWithSuffix = _addOrdinalSuffix(parsedDate.day);
    return "$dayWithSuffix ${DateFormat('MMM, yyyy').format(parsedDate)}";
  }

  String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  String formatTime(String? time) {
    if (time == null || time == "") return "";
    DateTime parsedDate = DateTime.parse(time).toLocal();
    return DateFormat('h:mm a').format(parsedDate);
  }

  String image(String? image) {
    if (image == null) return "";
    return image.airlineImage;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(image(airTicketModel.Airline)),
                    height: 60,
                    width: 100,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DetailCard(
                title: "Flight Number",
                subtitle: airTicketModel.FlightNumber,
                detailsCardWidth: double.infinity,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DetailCard(
                        title: "Depature",
                        subtitle: formatTime(airTicketModel.DepartureDate),
                        bottomTitleVisible: true,
                        bottomTitle: formatDate(airTicketModel.DepartureDate)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  if (airTicketModel.ArrivalDate != null ||
                      airTicketModel.ArrivalDate!.isNotEmpty)
                    DetailCard(
                      title: "Arrival",
                      subtitle: formatTime(airTicketModel.ArrivalDate),
                      bottomTitleVisible: true,
                      bottomTitle: formatDate(airTicketModel.ArrivalDate),
                    )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailCard(
                    titleVisible: false,
                    detailsCardWidth: 90,
                    subtitle: airTicketModel.SeatNumber ?? '',
                    bottomTitle: "Seats",
                    bottomTitleVisible: true,
                  ),
                  DetailCard(
                    titleVisible: false,
                    detailsCardWidth: 90,
                    subtitle: airTicketModel.Terminal ?? '',
                    bottomTitle: "Terminal",
                    bottomTitleVisible: true,
                  ),
                  DetailCard(
                    titleVisible: false,
                    detailsCardWidth: 90,
                    subtitle: airTicketModel.Gate ?? '',
                    bottomTitle: "Gate",
                    bottomTitleVisible: true,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? bottomTitle;
  final double? height;
  final double? detailsCardWidth;
  final bool? bottomTitleVisible;
  final bool? titleVisible;
  const DetailCard(
      {super.key,
      this.title,
      this.subtitle,
      this.bottomTitle,
      this.height,
      this.detailsCardWidth,
      this.bottomTitleVisible = false,
      this.titleVisible = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: detailsCardWidth,
      decoration: BoxDecoration(
          color: AppColors.boardingPassTile,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titleVisible == true) ...[
              Text(
                title ?? '',
                style: getLabelTextMedium(),
              ),
            ],
            Text(
              subtitle ?? "",
              style: getTileTitleLarge(),
            ),
            if (bottomTitleVisible == true) ...[
              SizedBox(height: height ?? 5),
              Text(
                bottomTitle ?? "",
                style: getAirTicketContentMedium(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
