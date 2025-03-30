import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/offers_usecase/get_offers_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/offers/offers_cubit/offers_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/offer_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_manager.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_appbar.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(showLeadingIcon: true, title: "Offers"),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: BlocProvider(
          create: (context) =>
              OffersCubit(getOffersUsecase: getIt.get<GetOffersUsecase>())
                ..getOffers(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  BlocBuilder<OffersCubit, OffersState>(
                    builder: (context, state) {
                      if (state is OffersInitialState) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.dateTimeColor,
                          ),
                        );
                      } else if (state is OffersErrorState) {
                        return Center(
                          child: Text(
                            "Failed to load offers.",
                            style: getContentTextMedium(),
                          ),
                        );
                      } else if (state is OffersLoadedState) {
                        if (state.offersList == null) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 70.0),
                            child: Center(
                              child: Image.asset(
                                "assets/images/percentage.png",
                                width: MediaQuery.of(context).size.height * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                opacity: AlwaysStoppedAnimation(0.7),
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 0.87),
                              itemCount: state.offersList!.length,
                              itemBuilder: (context, index) {
                                return OfferTile(
                                    onTap: () {
                                      GoRouter.of(context).pushNamed(
                                          Routes.offer,
                                          extra: state.offersList![index]);
                                    },
                                    image:
                                        "assets/images/image_placeholder.jpg",
                                    offer:
                                        state.offersList![index].Title ?? '');
                              }),
                        );
                      }
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.dateTimeColor,
                        ),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
