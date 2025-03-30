import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/air_tickets_ucecase/get_air_tickets_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/air_ticket/air_tickets_extension.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/font_manager.dart';
import '../../../core/constants/image_paths.dart';
import '../../widgets/air_ticket_card.dart';
import 'air_ticket_cubit/air_ticket_cubit.dart';

class AirTicketScreen extends StatelessWidget {
  const AirTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar(
          title: "Air Tickets",
          actions: true,
          label: "Book Now",
          onPressed: () {
            GoRouter.of(context).pushNamed(Routes.airTicketRequest);
          },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 25.0),
                decoration: BoxDecoration(
                  color: AppColors.tileColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelColor: AppColors.textColor,
                  unselectedLabelColor: AppColors.secondaryColor,
                  labelStyle: const TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontWeights.semiBold,
                    fontSize: FontSizes.s14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontWeights.semiBold,
                    fontSize: FontSizes.s14,
                  ),
                  tabs: const [
                    Tab(text: "Round Trips"),
                    Tab(text: "One Way"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildAirTicketsList(
                      context: context,
                      flightType: "Round Trip",
                    ),
                    _buildAirTicketsList(
                      context: context,
                      flightType: "Direct Flight",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null || date == "" ) return "";
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

  String formatTime(String? date) {
    if (date == null) return "";
    DateTime parsedDate = DateTime.parse(date).toLocal();
    return DateFormat('h:mm a').format(parsedDate); 
  }

  Widget _buildAirTicketsList({
    required BuildContext context,
    required String flightType,
  }) {
    return BlocProvider(
      create: (context) => AirTicketsCubit(
          getAirTicketsUsecase: getIt.get<GetAirTicketsUsecase>())
        ..getAirTickets(),
      child: BlocBuilder<AirTicketsCubit, AirTicketsState>(
        builder: (context, state) {
          if (state is AirTicketInitialState) {
            return CupertinoActivityIndicator(color: AppColors.dateTimeColor);
          } else if (state is AirTicketErrorState) {
            return Center(
              child: Text(
                "Failed to load air tickets.",
                style: getContentTextMedium(),
              ),
            );
          } else if (state is AirTicketLoadedState) {
            final filteredTickets = state.airTicketInfoList
                ?.where((ticket) => ticket.TripType == flightType)
                .toList();

            if (filteredTickets == null || filteredTickets.isEmpty) {
              return Center(
                child: Image.asset(
                  "assets/images/aircraft.png",
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                final info = filteredTickets[index];
                final airlineImage =
                    info.Airline?.airlineImage ??
                        Airlines.srilankan;
                return AirTicketCard(
                  airline: airlineImage,
                  departureCountry: '',
                  arrivalCountry: '',
                  departure: info.DepartureAirport ?? '',
                  arrival: 'CMB',
                  departureDate: formatDate(info.DepartureDate),
                  arrivalDate: formatDate(info.ArrivalDate),
                  departureTime: formatTime(info.DepartureDate),
                  arrivalTime: formatTime(info.DepartureDate),
                  flightClass: info.Class ?? '',
                  amount: info.Price!.toInt(),
                  flyingHours: "6hrs",
                  flightType: flightType,
                  onTap: () {
                    GoRouter.of(context).pushNamed(Routes.boardingPass,
                        extra: state.airTicketInfoList![index]);
                  },
                );
              },
            );
          }
          return CupertinoActivityIndicator(color: AppColors.dateTimeColor);
        },
      ),
    );
  }
}
