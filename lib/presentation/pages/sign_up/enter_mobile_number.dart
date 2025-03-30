import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/data/models/flow_type_model/flow_type_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/send_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/verify_mobile_number_usecase/verify_mobile_number_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/otp_cubit/otp_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/verify_mobile_cubit/verify_mobile_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_mobile_number_picker.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:bellagio_mobile_user/presentation/widgets/socials_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/style_manager.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../domain/usecases/sign_up_usecase/sign_up_usecase.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_snackbar.dart';
import 'sign_up_cubit/sign_up_cubit.dart';

class EnterMobileNumberScreen extends StatefulWidget {
  // final SignUpModel? signUpModel;
  final FlowTypeWrapperModel flowTypeWrapperModel;
  const EnterMobileNumberScreen(
      {super.key, required this.flowTypeWrapperModel});

  @override
  State<EnterMobileNumberScreen> createState() =>
      _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  late String phoneNumber;
  String country = "";
  String _userId = "";
  String _countryCode = '';
  late SignUpCubit _signUpCubit;
  late VerifyMobileCubit _verifyMobileCubit;

  @override
  void initState() {
    super.initState();
    _getUserId();
    initialise();
    phoneNumber = '';
  }

  void _getUserId() async {
    final sharedPrefManager = SharedPrefManager();
    final userId =
        await sharedPrefManager.getUserId(); // Resolve the Future here
    if (userId != null) {
      setState(() {
        _userId = userId; // Assign the actual value, not the Future
      });
    } else {}
  }

  void _handlePhoneNumberChanged(String number) {
    setState(() {
      phoneNumber = number;
    });
  }

  void _handleCountry(String country) {
    setState(() {
      country = country;
    });
  }

  void _handleCountryCode(String countryCode) {
    setState(() {
      _countryCode = countryCode;
    });
  }

  Future<void> initialise() async {
    _signUpCubit = SignUpCubit(signUpUsecase: getIt.get<SignUpUsecase>());
    _verifyMobileCubit = VerifyMobileCubit(
        verifyMobileNumberUsecase: getIt.get<VerifyMobileNumberUsecase>());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              OtpCubit(sendOtpUsecase: getIt.get<SendOtpUsecase>()),
        ),
        BlocProvider(
          create: (context) => VerifyMobileCubit(
              verifyMobileNumberUsecase:
                  getIt.get<VerifyMobileNumberUsecase>()),
        ),
      ],
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  const BoxDecoration(gradient: AppColors.backgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      Gradients(
                        text: "Enter your phone number",
                        style: gradientTitleTextLarge,
                        gradient: AppColors.accentColor,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Otp will be sent to your mobile phone",
                        style: getContentTextLarge(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomMobileNumberPicker(
                        phoneNumber: _handlePhoneNumberChanged,
                        country: _handleCountry,
                        countryCode: _handleCountryCode,
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      PrimaryButton(
                        label: "Send otp",
                        buttonStyleType: ButtonStyleType.filled,
                        onPressed: () async {
                          if (widget.flowTypeWrapperModel.flowType ==
                              FlowType.fogotPassword) {
                            final verification = await context
                                .read<VerifyMobileCubit>()
                                .verifyMobile(phoneNumber);

                            if (verification is DataFailed) {
                              showHoveringSnackbar(context,
                                  "Mobile number verification failed.");
                            } else {
                              final response = await context
                                  .read<OtpCubit>()
                                  .sendOtp(phoneNumber, _userId);
                              if (response is DataFailed) {
                                showHoveringSnackbar(
                                    context, "Failed to send the otp.");
                              } else {
                                showHoveringSnackbar(
                                    context, "Otp sent successfully!");
                                Future.delayed(Duration(seconds: 2));

                                await GoRouter.of(context).pushNamed(
                                    Routes.enterOtp,
                                    extra: FlowTypeWrapperModel(
                                        flowType: widget
                                            .flowTypeWrapperModel.flowType,
                                        mobileNumber: phoneNumber,
                                        signUpModel:
                                            SignUpModel(Phone: phoneNumber)));
                              }
                            }
                          } else {
                            final model = SignUpModel(
                                FirstName: widget.flowTypeWrapperModel
                                    .signUpModel!.FirstName,
                                LastName: widget
                                    .flowTypeWrapperModel.signUpModel!.LastName,
                                Email: widget
                                    .flowTypeWrapperModel.signUpModel!.Email,
                                Password: widget
                                    .flowTypeWrapperModel.signUpModel!.Password,
                                Phone: phoneNumber,
                                ProfileImage: "NA",
                                CountryCode: country);
                            final response = await context
                                .read<OtpCubit>()
                                .sendOtp(phoneNumber, _userId);
                            if (response is DataFailed) {
                              showHoveringSnackbar(
                                  context, "Failed to send the otp.");
                            } else {
                              showHoveringSnackbar(
                                  context, "Otp sent successfully!");
                              Future.delayed(const Duration(seconds: 2));

                              await GoRouter.of(context).pushNamed(
                                  Routes.enterOtp,
                                  extra: FlowTypeWrapperModel(
                                      flowType:
                                          widget.flowTypeWrapperModel.flowType,
                                      signUpModel: model));
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
