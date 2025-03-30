import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/request_usecase/request_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/requests/requests_cubit/requests_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'one_way_ticket.dart';
import 'round_trip_ticket.dart';

class AirTicketRequest extends StatelessWidget {
  AirTicketRequest({Key? key}) : super(key: key);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar(
          title: "Air Ticket Request",
          actions: false,
        ),
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                        Tab(text: "Round Trip"),
                        Tab(text: "One Way"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocProvider(
                      create: (context) => RequestCubit(
                          requestUsecase: getIt.get<RequestUsecase>()),
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(child: RoundTripTicket()),
                          SingleChildScrollView(child: OneWayTicket()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: AppColors.purple3.withOpacity(0.85),
                child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                        color: AppColors.secondaryColor, size: 70)),
              ),
            ),
        ]
        ),
      ),
    );
  }
}
