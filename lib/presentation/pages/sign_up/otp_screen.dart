import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/data/models/flow_type_model/flow_type_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/sign_up_usecase/sign_up_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/resend_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/validate_otp_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/otp_cubit/otp_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/sign_up_cubit/sign_up_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_mobile_number_picker.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_snackbar.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:bellagio_mobile_user/presentation/widgets/socials_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/style_manager.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../routes/routes.dart';
import '../../widgets/otp_input_field.dart';

class EnterOtpScreen extends StatefulWidget {
  final FlowTypeWrapperModel flowTypeWrapperModel;

  const EnterOtpScreen({super.key, required this.flowTypeWrapperModel});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  late int _otp;
  late ResendOtpUsecase resendOtpUsecase;
  String? _userId;

  @override
  void initState() {
    super.initState();

    _getUserId();
  }

  void _handleOtp(int otp) {
    setState(() {
      _otp = otp;
    });
    debugPrint('OTP received from child: $_otp');
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpCubit(
            resendOtpUsecase: getIt.get<ResendOtpUsecase>(),
            validateOtpUsecase: getIt.get<ValidateOtpUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              SignUpCubit(signUpUsecase: getIt.get<SignUpUsecase>()),
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
                        text: "Enter OTP",
                        style: gradientTitleTextLarge,
                        gradient: AppColors.accentColor,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "A 6 digit code has been sent to your mobile number starting with ${widget.flowTypeWrapperModel.signUpModel!.Phone}",
                        style: getContentTextLarge(),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      OtpInputField(otp: _handleOtp),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't recieve Otp? ",
                            style: getContentTextMedium(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final String phone;
                              if (widget.flowTypeWrapperModel.flowType ==
                                  FlowType.fogotPassword) {
                                phone =
                                    widget.flowTypeWrapperModel.mobileNumber ??
                                        '';
                              } else {
                                phone = widget.flowTypeWrapperModel.signUpModel!
                                        .Phone ??
                                    "";
                              }
                              final response = await context
                                  .read<OtpCubit>()
                                  .resendOtp(phone);
                              if (response is DataFailed) {
                                showHoveringSnackbar(
                                    context, "Failed to resend otp.");
                              } else {
                                showHoveringSnackbar(
                                    context, "Otp sent successfully!!");
                                // await GoRouter.of(context).pushNamed(Routes.home);
                              }
                            },
                            child: Text(
                              "Resend",
                              style: getLinkTextSmall(
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      PrimaryButton(
                        label: "Submit",
                        buttonStyleType: ButtonStyleType.filled,
                        onPressed: () async {
                          final String phone;
                          if (widget.flowTypeWrapperModel.flowType ==
                              FlowType.fogotPassword) {
                            phone =
                                widget.flowTypeWrapperModel.mobileNumber ?? '';
                          } else {
                            phone = widget
                                    .flowTypeWrapperModel.signUpModel!.Phone ??
                                "";
                          }
                          final result = await context
                              .read<OtpCubit>()
                              .validateOtp(phone, _otp);
                          if (result is DataFailed) {
                            showHoveringSnackbar(
                                context, "Otp failed! Please check again.");
                          } else {
                            // check the flow whether it is the forgot password or the sign up
                            if (widget.flowTypeWrapperModel.flowType ==
                                FlowType.signUp) {
                              GoRouter.of(context).goNamed(Routes.signUp,
                                  extra: FlowTypeWrapperModel(
                                      flowType: FlowType.signUp,
                                      signUpModel: widget
                                          .flowTypeWrapperModel.signUpModel));
                            } else {
                              showHoveringSnackbar(
                                  context, "Mobile number verified!");
                              await GoRouter.of(context).pushNamed(
                                  Routes.forgotPassword,
                                  extra: FlowTypeWrapperModel(
                                      flowType:
                                          widget.flowTypeWrapperModel.flowType,
                                      mobileNumber: phone,
                                      signUpModel: widget
                                          .flowTypeWrapperModel.signUpModel));
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
