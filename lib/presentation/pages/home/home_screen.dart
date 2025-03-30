import 'dart:convert';
import 'dart:io';

import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/get_gifts_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/gifts_usecase/redeem_gift_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_assigned_loyalty_card_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_loyalty_cards_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/offers_usecase/get_offers_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/user_info_usecase/user_info_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/gifts/gifts_cubit/gifts_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/home/home_screen_cubit/user_info_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/my_cards/loyalty_cards_cubit/loyalty_cards_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/my_cards/my_cards.dart';
import 'package:bellagio_mobile_user/presentation/pages/offers/offers_cubit/offers_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in.dart';
import 'package:bellagio_mobile_user/presentation/pages/video_player/home_video.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/horizontal_offers_view.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/image_paths.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../data/models/flow_type_model/flow_type_model.dart';
import '../../../data/models/qr_code_response_model/qr_code_return_model.dart';
import '../../widgets/custom_border_button.dart';
import '../../widgets/horizontal_card_view.dart';
import '../../widgets/horizontal_scroller_menu.dart';
import '../gifts/redeem_QR_cubit/redeem_QR_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  // final FlowTypeWrapperModel? model;
  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  String _userName = "";
  String card = "";
  String _bellagioId = "";
  String _userId = '';
  bool loadedCode = false;
  bool isFirstTime = false;
  String _bellagioPoints = "";
  String _otpPoints = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserName();
    // _checkFirstTimeUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check for loyalty ID and reload if missing
      // final loyaltyProgramId = SharedPrefManager().getLoyaltyProgramId();
      // if (loyaltyProgramId == null || loyaltyProgramId == "") {
      //   Future.delayed(Duration(seconds: 2), () {
      //     context.read<LoyaltyCardsCubit>()..getLoyaltCard();
      //   });
      // }
    });
  }

  void _getUserName() async {
    final sharedPrefManager = SharedPrefManager();
    final userName = await sharedPrefManager.getUserName();
    final bellagioId = await sharedPrefManager.getBellagioId();
    final loyaltyId = await sharedPrefManager.getLoyaltyProgramId();
    final userId = await sharedPrefManager.getUserId();
    final bellagioPoints = await sharedPrefManager.getBellagioPoints();
    final otpPoints = await sharedPrefManager.getOTPPoints();
    final firstname = await sharedPrefManager.getFirstname();
    final lastname = await sharedPrefManager.getLastname();
    await sharedPrefManager.saveUserName("${firstname} ${lastname}");
    if (firstname != null) {
      setState(() {
        print("===========${userName}");
        _userName =
            "${firstname} ${lastname}"; // Assign the actual value, not the Future
        _bellagioId = bellagioId ?? '';
        _userId = userId ?? '';
        _bellagioPoints = bellagioPoints ?? '';
        _otpPoints = otpPoints ?? '';
      });
    } else {
      setState(() {
        _userName = userName ?? ''; // Assign the actual value, not the Future
        _bellagioId = bellagioId ?? '';
        _userId = userId ?? '';
        _bellagioPoints = bellagioPoints ?? '';
        _otpPoints = otpPoints ?? '';
      });
    }
  }

  String _decodeBellagioId(String bellagioId) {
    String decodedId = utf8.decode(base64.decode(bellagioId));
    return decodedId;
  }

  void _showQRCodePopup(BuildContext context, String userId, String imageCard,
      bool isVerified, String? bellagioId, int? points, String userName) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.purple2,
          title: Text(
            isVerified ? 'Digital Id' : 'Scan QR Code',
            style: getContentTextLarge(),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional(-0.8, 0.8),
                  children: [
                    Container(
                      child: Image.asset(
                        imageCard,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: getLoyaltyCardUsername(),
                        ),
                        Text(
                          _decodeBellagioId(bellagioId ?? ''),
                          style: getLoyaltyCardUsername(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                isVerified
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 270,
                            height: 270,
                            child: QrImageView(
                              backgroundColor: Colors.white,
                              data: _decodeBellagioId(bellagioId ?? ''),
                              version: QrVersions.auto,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: AppColors.tileColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                children: [
                                  Gradients(
                                    gradient: AppColors.accentColor,
                                    text: _decodeBellagioId(bellagioId ?? ''),
                                    style: gradientContentTextLarge,
                                  ),
                                  Text(
                                    "Membership id",
                                    style: getContentTextMedium(),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: AppColors.tileColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                children: [
                                  Gradients(
                                    gradient: AppColors.accentColor,
                                    text: points.toString(),
                                    style: gradientContentTextLarge,
                                  ),
                                  Text(
                                    "Reward points",
                                    style: getContentTextMedium(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 300,
                            child: QrImageView(
                              backgroundColor: Colors.white,
                              data: userId,
                              version: QrVersions.auto,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Scan this QR Code to verify your ID',
                            style: getContentTextSmall(),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    ).then((_) async {
      setState(() {
        _isLoading = true;
      });
      // Trigger Cubit events again when dialog is dismissed
      await context.read<UserInfoCubit>().fetchUserInfo();

      await context.read<LoyaltyCardsCubit>().getLoyaltCard();
      context.read<GiftsCubit>().getGifts();

      // Rebuild the full page
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoyaltyCardsCubit(
            getAssignedLoyaltyCardsUsecase:
                getIt.get<GetAssignedLoyaltyCardsUsecase>(),
          )..getLoyaltCard(),
        ),
        BlocProvider(
          create: (context) =>
              GiftsCubit(getGiftsUsecase: getIt.get<GetGiftsUsecase>())
                ..getGifts(),
        ),
        BlocProvider(
            create: (context) => RedeemQrCubit(
                redeemGiftUsecase: getIt.call<RedeemGiftUsecase>())),
        BlocProvider(
            create: (context) =>
                UserInfoCubit(userInfoUsecase: getIt.call<UserInfoUsecase>())
                  ..fetchUserInfo())
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
          builder: (context, userInfostate) {
        if (userInfostate is UserInfoSuccessState) {
          final userModel = userInfostate.userInfoModel;
          final userName = "${userModel!.FirstName} ${userModel!.LastName}";
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration:
                  const BoxDecoration(gradient: AppColors.backgroundColor),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      fit: StackFit.passthrough,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: HomeScreenVideo(
                              videoAsset: "assets/videos/homeScreen_video.mp4"),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color.fromARGB(
                                      255, 53, 1, 45), // Top gradient color
                                  Colors
                                      .transparent, // Bottom transparent color
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: getTitleText(),
                          ),
                          Gradients(
                            text: userName,
                            gradient: AppColors.accentColor,
                            style: gradientTitleTextMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(Routes.packages);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25, right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: AppColors.accentColor),
                                  child: const Center(
                                    child: Icon(
                                      Icons.shopping_bag_rounded,
                                      color: AppColors.secondaryColor,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Packages",
                                  style: getButtonLabelMedium(),
                                )
                              ],
                            ),
                          ),
                        ),
                        RoundMenuButton(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(Routes.airTicketScreen);
                          },
                          icon: Icons.flight,
                          title: "Air tickets",
                        ),
                        RoundMenuButton(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(Routes.transportRequest);
                          },
                          icon: Icons.drive_eta,
                          title: "Transport",
                        ),
                        RoundMenuButton(
                          onTap: () {
                            // Show popup
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.purple2,
                                  title: Text("More Options",
                                      style: getContentTextLarge()),
                                  content: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RoundMenuButton(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                    Routes.hotelReservation);
                                              },
                                              icon: Icons.hotel_class_rounded,
                                              title: "Hotels"),
                                          RoundMenuButton(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                    Routes.offersScreen);
                                              },
                                              icon: Icons.percent_rounded,
                                              title: "Offers"),
                                          RoundMenuButton(
                                              onTap: () {
                                                GoRouter.of(context)
                                                    .pushNamed(Routes.gifts);
                                              },
                                              icon:
                                                  Icons.wallet_giftcard_rounded,
                                              title: "Gifts"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RoundMenuButton(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                    Routes.entertainment);
                                              },
                                              icon: Icons.attractions_outlined,
                                              title: "Events"),
                                          RoundMenuButton(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                    Routes.tournaments);
                                              },
                                              icon: Icons
                                                  .confirmation_num_outlined,
                                              title: "Draws"),
                                          RoundMenuButton(
                                              onTap: () {
                                                GoRouter.of(context)
                                                    .pushNamed(Routes.feedback);
                                              },
                                              icon: Icons.chat_outlined,
                                              title: "Feedback"),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icons.more_vert_outlined,
                          title: "More",
                        ),
                      ],
                    ),

                    // const HorizontalScrollerMenu(),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Loyalty cards",
                            style: getTitleText(),
                          ),
                          GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pushNamed(Routes.myCards);
                              },
                              child: Text(
                                "View more...",
                                style: getDateTimeLabel(),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoyaltyCardsCubit, LoyaltyCardState>(
                      builder: (context, loyaltyCardState) {
                        if (loyaltyCardState is LoyaltyCardInitialState ||
                            _isLoading) {
                          return Center(
                              child: CupertinoActivityIndicator(
                            color: AppColors.dateTimeColor,
                          ));
                        } else if (loyaltyCardState is LoyaltyCardErrorState) {
                          return Center(
                            child: Text(
                              "Failed to load loyalty card",
                              style: getContentTextMedium(),
                            ),
                          );
                        } else if (loyaltyCardState is LoyaltyCardLoadedState) {
                          if (loyaltyCardState.loyaltyCard == null) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.purple1,
                              ), // Show a loading indicator
                            );
                          }
                          final card = loyaltyCardState.loyaltyCard;
                          final cardImage = card!.Name?.loyaltyCardImage ??
                              LoyaltyCards.rafeles_club;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: LoyaltyCard(
                              cardName:
                                  loyaltyCardState.loyaltyCard!.Name ?? '',
                              bellagioPoints: double.tryParse(
                                      userModel.Points.toString()) ??
                                  0.0,
                              totalPoints: double.tryParse(loyaltyCardState
                                      .loyaltyCard!.TopLine
                                      .toString()) ??
                                  0.0,
                              activatedDate: "",
                              bottomLine: double.tryParse(loyaltyCardState
                                  .loyaltyCard!.MinimumRewardPoints
                                  .toString()),
                              otp: double.tryParse(
                                  userModel.OTPPoints.toString()),
                              username: userName,
                              image: cardImage,
                              bellagioId: userModel.BellagioId,
                              onTap: () {
                                _showQRCodePopup(
                                    context,
                                    _userId,
                                    cardImage,
                                    userModel.IsValidated ?? true,
                                    userModel.BellagioId,
                                    userModel.Points,
                                    userName);
                              },
                            ),
                          );
                        }
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.dateTimeColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Current gifts",
                            style: getTitleText(),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pushNamed(Routes.gifts);
                            },
                            child: Text(
                              "View more...",
                              style: getDateTimeLabel(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // HorizontalOffersView(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          BlocBuilder<GiftsCubit, GiftsState>(
                            builder: (context, giftstate) {
                              if (giftstate is GiftsInitialState) {
                                return Center(
                                  child: CupertinoActivityIndicator(
                                    color: AppColors.dateTimeColor,
                                  ),
                                );
                              } else if (giftstate is GiftsErrorState) {
                                return Center(
                                  child: Text(
                                    "Failed to load gifts.",
                                    style: getContentTextMedium(),
                                  ),
                                );
                              } else if (giftstate is GiftsLoadedState) {
                                if (giftstate.giftsList == null ||
                                    giftstate.giftsList!.isEmpty) {
                                  // Display message for empty list
                                  return Center(
                                    child: Text(
                                      "No gifts available.",
                                      style: getContentTextMedium(),
                                    ),
                                  );
                                }
                                // Check if all gifts have availability as "0"
                                bool allGiftsUnavailable = giftstate.giftsList!
                                    .every((gift) => gift.Avaialability == "0");

                                if (allGiftsUnavailable) {
                                  return Center(
                                    child: Text(
                                      "No gifts available.",
                                      style: getContentTextMedium(),
                                    ),
                                  );
                                }
                                // Directly use ListView.builder with constraints
                                return SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: giftstate.giftsList!.length,
                                    itemBuilder: (context, index) {
                                      // return HomeOfferTile(
                                      //   image:
                                      //       "assets/images/gift.png",
                                      //   offer: state.giftsList![index].Title ?? '',
                                      // );
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: (giftstate.giftsList![index]
                                                      .Avaialability !=
                                                  "0")
                                              ? CustomBorderButton(
                                                  buttonLabel: "View",
                                                  image:
                                                      "assets/images/gift.png",
                                                  title: giftstate
                                                          .giftsList![index]
                                                          .TypeOfGift ??
                                                      '',
                                                  onPressed: () async {
                                                    await GoRouter.of(context)
                                                        .pushNamed(
                                                            Routes.viewGifts,
                                                            extra: giftstate
                                                                    .giftsList![
                                                                index]);
                                                  },
                                                )
                                              : SizedBox());
                                    },
                                  ),
                                );
                              }
                              return const SizedBox(); // Fallback case
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
            child: CupertinoActivityIndicator(
          color: AppColors.dateTimeColor,
        ));
      }),
    );
    // );
  }
}
