import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/gifts_model/gifts_model.dart';
import 'package:bellagio_mobile_user/data/models/qr_code_response_model/qr_code_return_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/get_gifts_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/redeem_gift_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/gifts/redeem_QR_cubit/redeem_QR_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_border_button.dart';
import 'gifts_cubit/gifts_cubit.dart';

class GiftsScreen extends StatefulWidget {
  const GiftsScreen({super.key});

  @override
  State<GiftsScreen> createState() => _GiftsScreenState();
}

class _GiftsScreenState extends State<GiftsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(title: "Gifts"),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    GiftsCubit(getGiftsUsecase: getIt.get<GetGiftsUsecase>())
                      ..getGifts(),
              ),
              BlocProvider(
                  create: (context) => RedeemQrCubit(
                      redeemGiftUsecase: getIt.call<RedeemGiftUsecase>())),
            ],
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                BlocBuilder<GiftsCubit, GiftsState>(
                  builder: (context, state) {
                    if (state is GiftsInitialState) {
                      return Center(
                        child: CupertinoActivityIndicator(
                            color: AppColors.dateTimeColor),
                      );
                    } else if (state is GiftsErrorState) {
                      return Center(
                          child: Text(
                        "Failed to load gifts",
                        style: getContentTextMedium(),
                      ));
                    } else if (state is GiftsLoadedState) {
                      bool allGiftsUnavailable = state.giftsList!
                          .every((gift) => gift.Avaialability == "0");

                      if (allGiftsUnavailable) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                          child: Center(
                            child: Image.asset(
                              "assets/images/giftBox.png",
                              width: MediaQuery.of(context).size.height * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
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
                            itemCount: state.giftsList!.length,
                            itemBuilder: (context, index) {
                              return (state.giftsList![index].Avaialability !=
                                      "0")
                                  ? CustomBorderButton(
                                      onPressed: () async {
                                        await GoRouter.of(context).pushNamed(
                                            Routes.viewGifts,
                                            extra: state.giftsList![index]);
                                      },
                                      buttonLabel: "View",
                                      image: "assets/images/gift.png",
                                      title:
                                          state.giftsList![index].TypeOfGift ??
                                              '',
                                    )
                                  : SizedBox();
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
            ),
          ),
        ),
      ),
    );
  }
}
