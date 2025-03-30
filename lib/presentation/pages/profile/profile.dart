import 'dart:convert';
import 'dart:io';

import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/domain/usecases/loyalty_cards_usecase/get_loyalty_cards_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_package_by_package_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/packages_usecase/get_packages_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/update_profile_image_usecase/update_profile_image.dart';
import 'package:bellagio_mobile_user/presentation/pages/home/home_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/my_cards/loyalty_cards_cubit/loyalty_cards_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/my_cards/my_cards.dart';
import 'package:bellagio_mobile_user/presentation/pages/packages/packages_cubit/packages_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/profile/profile_image_cubit/profile_image_cubit.dart';
import 'package:bellagio_mobile_user/presentation/routes/routes.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_appbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/horizontal_card_view.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/constants/image_paths.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../domain/repositories/file_uploader_repository/file_uploader_repository.dart';
import '../../../domain/usecases/file_uploader_usecase/file_uploader_usecase.dart';
import '../../../domain/usecases/loyalty_cards_usecase/get_assigned_loyalty_card_usecase.dart';
import '../../../domain/usecases/user_info_usecase/user_info_usecase.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen_cubit/user_info_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';
  String _userId = "";
  bool isUploading = false;
  bool uploadSuccess = false;
  String? profileImageUrl;
  bool _isLoading = false;
  String card = "";
  ImagePicker imagePicker = ImagePicker();
  final sharedPrefManager = SharedPrefManager();

  @override
  void initState() {
    super.initState();
    ProfileImageCubit(
        updateProfileImageUsecase: getIt.call<UpdateProfileImageUsecase>());
  }

  void logOut(BuildContext context) async {
    await sharedPrefManager.clearAll();
    await sharedPrefManager.clearManagerId();
    await FirebaseAuth.instance.signOut();
    GoRouter.of(context).goNamed(Routes.signIn);
  }

  Future<void> _pickAndSubmitImage(BuildContext context) async {
    final pickedImage = await showDialog<XFile?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select an image source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop(await imagePicker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 30,
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop(await imagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 30,
                  ));
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedImage != null) {
      File file = File(pickedImage.path);

      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);

      FormData formData = FormData();
      formData.files.add(MapEntry('file', multipartFile));
      formData.fields.add(MapEntry('userId', _userId));
      formData.fields.add(MapEntry('customerName', _userName));

      _uploadImage(_userName, _userId, file);
    } else {
      showHoveringSnackbar(context, 'No image selected');
    }
  }

  Future<void> _updateImage(String? url) async {
    final updateImageCubit = ProfileImageCubit(
        updateProfileImageUsecase: getIt.call<UpdateProfileImageUsecase>());
    final updateImage = await updateImageCubit.createRequest(url ?? '');

    if (updateImage is DataFailed) {
      return showHoveringSnackbar(context, 'Update failed!');
    } else {
      return showHoveringSnackbar(context, 'Update success!');
    }
  }

  String cleanUrl(String url) {
    return url.replaceAll('"', '');
  }

  Future<void> _uploadImage(String userName, String userId, File file) async {
    setState(() {
      isUploading = true;
    });

    final FileUploaderUsecase fileUploaderUsecase =
        getIt.get<FileUploaderUsecase>();

    try {
      showHoveringSnackbar(context, "Uploading");
      final response = await fileUploaderUsecase(userName, userId, file);

      if (response is DataSuccess && response.data != null) {
        setState(() {
          isUploading = false;
          profileImageUrl = response.data;
          uploadSuccess = true;
        });

        final image = cleanUrl(profileImageUrl ?? '');

        _updateImage(image);
      } else {
        setState(() {
          isUploading = false;
        });
        showHoveringSnackbar(context, 'Image upload failed! Please try again');
      }
    } catch (e) {
      setState(() {
        isUploading = false;
      });

      showHoveringSnackbar(context, 'Image upload failed! Please try again');
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
      context.read<PackagesCubit>().getAssignedPackage();

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
                      getIt.get<GetAssignedLoyaltyCardsUsecase>())
                ..getLoyaltCard()),
          BlocProvider(create: (context) => ProfileImageCubit()),
          BlocProvider(
            create: (context) =>
                UserInfoCubit(userInfoUsecase: getIt.get<UserInfoUsecase>())
                  ..fetchUserInfo(),
          ),
          BlocProvider(
            create: (context) => PackagesCubit(
                getPackageByPackageIdUsecase:
                    getIt.get<GetPackageByPackageIdUsecase>())
              ..getAssignedPackage(),
          ),
        ],
        child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: CustomAppbar(
              title: "Profile",
              showLeadingIcon: false,
              label: "Log out",
              actions: true,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColors.purple2,
                        title: Text(
                          "Log out?",
                          style: getContentTextLarge(),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Are you sure you want to log out?",
                              style: getButtonLabelMedium(),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              logOut(context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.secondaryColor)),
                            child: Text("Logout", style: getLabelTextMedium()),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.tileColor)),
                            child: Text(
                              "Close",
                              style: getContentTextSmall(),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  const BoxDecoration(gradient: AppColors.backgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: SingleChildScrollView(
                  child: BlocBuilder<UserInfoCubit, UserInfoState>(
                      builder: (context, state) {
                    if (state is UserInfoInitial) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.dateTimeColor,
                        ),
                      );
                    }
                    if (state is UserInfoSuccessState || _isLoading) {
                      final userInfo = state.userInfoModel;
                      final userName =
                          "${userInfo?.FirstName} ${userInfo?.LastName}";
                      final profileImage = userInfo?.ProfileImage;
                      final image = (profileImage == "N/A" ||
                              profileImage == null ||
                              profileImage.isEmpty)
                          ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                          : profileImage.trimRight();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(image),
                                    radius: 50,
                                  ),
                                  // Edit Button
                                  GestureDetector(
                                    onTap: () {
                                      _pickAndSubmitImage(context);
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.secondaryColor,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColors.textColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Gradients(
                                gradient: AppColors.accentColor,
                                text: userName,
                                style: gradientContentTextLarge,
                              ),
                              Text(
                                "${userInfo?.Email}",
                                style: getDateTimeLabel(),
                              ),
                              if (userInfo?.IsValidated == false)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "QID : ${userInfo?.QId}",
                                      style: getContentTextMedium(),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.tileColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // width: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Gradients(
                                            gradient: AppColors.accentColor,
                                            text: _decodeBellagioId(
                                                userInfo?.BellagioId ?? ''),
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
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.tileColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Gradients(
                                            gradient: AppColors.accentColor,
                                            text: userInfo?.Points.toString(),
                                            style: gradientContentTextLarge,
                                          ),
                                          Text(
                                            "Reward points",
                                            style: getContentTextMedium(),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Current package",
                            style: getTitleText(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<PackagesCubit, PackagesState>(
                            builder: (context, packageState) {
                              if (packageState is PackageInitialState) {
                                return Center(
                                  child: CupertinoActivityIndicator(
                                    color: AppColors.dateTimeColor,
                                  ),
                                );
                              } else if (packageState is PackageErrorState) {
                                return PrimaryButton(
                                    label: "Buy package",
                                    onPressed: () {
                                      GoRouter.of(context).pushNamed(
                                        Routes.packages,
                                      );
                                    },
                                    buttonStyleType: ButtonStyleType.filled);
                              } else if (packageState is PackageLoadedState) {
                                if (packageState.package == null) {
                                  return PrimaryButton(
                                      label: "Buy package",
                                      onPressed: () {
                                        GoRouter.of(context).pushNamed(
                                          Routes.packages,
                                        );
                                      },
                                      buttonStyleType: ButtonStyleType.filled);
                                } else {
                                  final formattedPrice = NumberFormat.currency(
                                    symbol:
                                        '${packageState.package!.Currency} ',
                                    decimalDigits: 0,
                                  ).format(packageState.package!.Price);
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.tileColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Gradients(
                                            gradient: AppColors.accentColor,
                                            text: packageState.package!.Name,
                                            style: gradientContentTextMedium,
                                          ),
                                          Text(
                                            formattedPrice,
                                            style: getContentTextLarge(),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }
                              return PrimaryButton(
                                  label: "Buy package",
                                  onPressed: () {
                                    GoRouter.of(context).pushNamed(
                                      Routes.packages,
                                    );
                                  },
                                  buttonStyleType: ButtonStyleType.filled);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Loyalty card",
                            style: getTitleText(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<LoyaltyCardsCubit, LoyaltyCardState>(
                            builder: (context, loyaltyCardState) {
                              if (loyaltyCardState is LoyaltyCardInitialState ||
                                  _isLoading) {
                                return Center(
                                    child: CupertinoActivityIndicator(
                                  color: AppColors.dateTimeColor,
                                ));
                              } else if (loyaltyCardState
                                  is LoyaltyCardErrorState) {
                                return Center(
                                  child: Text(
                                    "Failed to load loyalty card",
                                    style: getContentTextMedium(),
                                  ),
                                );
                              } else if (loyaltyCardState
                                  is LoyaltyCardLoadedState) {
                                final card = loyaltyCardState.loyaltyCard;
                                final cardImage =
                                    card!.Name?.loyaltyCardImage ??
                                        LoyaltyCards.rafeles_club;
                                return LoyaltyCard(
                                  cardName:
                                      loyaltyCardState.loyaltyCard!.Name ?? '',
                                  bellagioPoints: double.tryParse(
                                          userInfo?.Points.toString() ?? '') ??
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
                                          userInfo?.OTPPoints.toString() ??
                                              '') ??
                                      0.0,
                                  image: cardImage,
                                  bellagioId: userInfo?.BellagioId,
                                  username: userName,
                                  onTap: () {
                                    _showQRCodePopup(
                                        context,
                                        _userId,
                                        cardImage,
                                        userInfo?.IsValidated ?? true,
                                        userInfo?.BellagioId,
                                        userInfo?.Points,
                                        userName);
                                  },
                                );
                              }
                              return Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColors.dateTimeColor,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }
                    return Center(
                      child: CupertinoActivityIndicator(
                        color: AppColors.dateTimeColor,
                      ),
                    );
                  }),
                ),
              ),
            )));
  }
}
