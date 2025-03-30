import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_loyalty_cards_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/my_cards/loyalty_cards_cubit/loyalty_cards_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package
import '../../../core/constants/color_manager.dart';
import '../../../core/constants/image_paths.dart';
import '../../widgets/loyalty_cards_slider.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "My cards"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: BlocProvider(
          create: (context) => LoyaltyCardsCubit(
              getLoyaltyCardsUsecase: getIt.get<GetLoyaltyCardsUsecase>())
            ..getLoyaltyCards(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<LoyaltyCardsCubit, LoyaltyCardState>(
                  builder: (context, state) {
                    if (state is LoyaltyCardsInitialState) {
                      return CupertinoActivityIndicator(
                          color: AppColors.dateTimeColor);
                    } else if (state is LoyaltyCardsErrorState) {
                      return Text(
                        "Failed to load loyalty cards",
                        style: getContentTextMedium(),
                      );
                    } else if (state is LoyaltyCardsLoadedState) {
                      if (state.cardsList == null || state.cardsList!.isEmpty) {
                        return const Center(
                          child:
                              CupertinoActivityIndicator(), // Show a loading indicator
                        );
                      }

                      return PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.cardsList!.length,
                        itemBuilder: (context, index) {
                          final cardImage = state.cardsList![index].Name?.loyaltyCardImage ??
                              LoyaltyCards.rafeles_club;
                          return Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: LoyaltyCardsSlider(
                                image: cardImage,
                                title: state.cardsList![index].Name ?? '',
                                status:
                                    state.cardsList![index].IsActive ?? false,
                                // activatedOn: "01 January 2024",
                                earnedPoints:
                                    state.cardsList![index].MinimumRewardPoints ?? 0,
                                totalPoints:
                                    state.cardsList![index].TopLine ?? 0,
                                    description: state.cardsList![index].Description
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child:
                          CupertinoActivityIndicator(), // Show a loading indicator
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              BlocBuilder<LoyaltyCardsCubit, LoyaltyCardState>(
                builder : (context, state) {
                     
                     
                  final cardCount = state is LoyaltyCardsLoadedState &&
                          state.cardsList != null
                      ? state.cardsList!.length
                      : 0;
                return SmoothPageIndicator(
                controller: _pageController,
                count: cardCount,
                effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 50,
                      activeDotColor: AppColors.secondaryColor,
                      dotColor: AppColors.tileColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

extension LoyaltyCardImageExtension on String {
  String get loyaltyCardImage {
    switch (this) {
      case "Gold":
        return LoyaltyCards.gold;
      case "Premier":
        return LoyaltyCards.premiere;
      case "Rafels Club":
        return LoyaltyCards.rafeles_club;
      case "Platinum":
        return LoyaltyCards.platinum;
      default:
        return LoyaltyCards.premiere;
    }
  }
}
