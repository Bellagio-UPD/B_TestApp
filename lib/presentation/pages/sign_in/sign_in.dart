import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
import 'package:bellagio_mobile_user/data/models/login_user_model.dart/login_user_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/fcm_register_usecase/fcm_token_register_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/login_user_usecase.dart/login_user_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/user_info_usecase/user_info_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/validate_otp_usecase/send_otp_usecase.dart';
import 'package:bellagio_mobile_user/domain/usecases/verify_mobile_number_usecase/verify_mobile_number_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/home/home_screen_cubit/user_info_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in_cubit/sign_in_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/otp_cubit/otp_cubit.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/verify_mobile_cubit/verify_mobile_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:bellagio_mobile_user/presentation/widgets/socials_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constants/style_manager.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../data/models/flow_type_model/flow_type_model.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_mobile_number_picker.dart';
import '../../widgets/custom_snackbar.dart';
import '../sign_up/fcm_register_cubit/fcm_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isVisible = false;
  bool _isDisable = false;
  bool _isLoading = false;
  String? phoneNumber = "";
  String? password = '';
  String? _country = '';
  String? _countryCode = "";
  final _formKey = GlobalKey<FormState>();
  RegExp stringValidation = RegExp(r'^[a-zA-Z\s]+$');
  RegExp intValidation = RegExp(r'^\d+$');
  String appVersion = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppVersion();
    // UserInfoCubit(userInfoUsecase: getIt.get<UserInfoUsecase>())
    //   ..fetchUserInfo();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version; // Example: 1.0.0
    });
  }

  void _handlePhoneNumberChanged(String number) {
    setState(() {
      phoneNumber = number;
    });
  }

  void _handleCountryCode(String countryCode) {
    setState(() {
      _countryCode = countryCode;
    });
  }

  void _handleCountry(String country) {
    setState(() {
      _country = country;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login(String? phone, String? password) async {
    setState(() {
      _isLoading = true;
    });
    String mobile = phone!.replaceAll("+", "0");
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: "${mobile}@bellagio.com", password: password ?? "");

      // Get the user object
      User? user = userCredential.user;
      final sharedPrefManager = SharedPrefManager();

      if (user != null) {
        // Retrieve the ID token
        String token = await user.getIdToken() ?? '';

        // Decode the token to extract claims
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        // Retrieve custom claims (e.g., userName)
        String? userName = decodedToken['userName'];
        String userId = user.uid;

        // Save data to shared preferences
        await sharedPrefManager.saveToken(token);
        await sharedPrefManager.saveUserName(userName ?? '');
        await sharedPrefManager.saveUserId(userId);

        FirebaseMessaging.instance.getToken().then((token) async {
          final result = await FCMCubit(
              fcmTokenRegisterUsecase: getIt.get<FCMTokenRegisterUsecase>())
            ..fcmTokenRegister(token!, userId);

          if (result is DataFailed) {}
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Login successful! Welcome $userName')),
        // );

        final result = await context.read<UserInfoCubit>()
          ..fetchUserInfo();
        await Future.delayed(
          const Duration(seconds: 3),
        );

        if (result is DataFailed) {
          setState(() {
            _isLoading = false; // Hide loading overlay
          });
          showHoveringSnackbar(context, "Failed to get user information.");
        } else {
          GoRouter.of(context).goNamed(Routes.navDashboard,
              extra: FlowTypeWrapperModel(flowType: FlowType.signIn));
        }
      }

      // final userInfo = await context.read<UserInfoCubit>().state;
    } catch (e) {
      setState(() {
        _isLoading = false; // Hide loading overlay
      });
      showHoveringSnackbar(context, "Invalid mobile number or password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignInCubit(loginUserUsecase: getIt.get<LoginUserUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              OtpCubit(sendOtpUsecase: getIt.get<SendOtpUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              UserInfoCubit(userInfoUsecase: getIt.get<UserInfoUsecase>()),
        ),
        BlocProvider(
          create: (context) => VerifyMobileCubit(
              verifyMobileNumberUsecase:
                  getIt.get<VerifyMobileNumberUsecase>()),
        ),
        BlocProvider(
          create: (context) => FCMCubit(
              fcmTokenRegisterUsecase: getIt.get<FCMTokenRegisterUsecase>()),
        ),
      ],
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: AppColors.backgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                              ),
                              Gradients(
                                text: "Sign in",
                                style: gradientTitleTextLarge,
                                gradient: AppColors.accentColor,
                              ),
                              const SizedBox(height: 40),
                              Text("Mobile number",
                                  style: getContentTextLarge()),
                              SizedBox(
                                height: 10,
                              ),
                              CustomMobileNumberPicker(
                                phoneNumber: _handlePhoneNumberChanged,
                                country: _handleCountry,
                                countryCode: _handleCountryCode,
                              ),
                              const SizedBox(height: 10),
                              Visibility(
                                visible: _isVisible,
                                child: Column(
                                  children: [
                                    CustomTextfield(
                                      hint: "Enter your password",
                                      obscureText: true,
                                      label: "Password",
                                      onChanged: (value) {
                                        password = value!;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        } else if (value.length < 6) {
                                          return "Password must contain minimum 6 characters";
                                        }
                                        return null;
                                      },
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context).pushNamed(
                                                Routes.enterMobileNumber,
                                                extra: FlowTypeWrapperModel(
                                                    flowType:
                                                        FlowType.fogotPassword,
                                                    signUpModel: SignUpModel(
                                                        Phone: phoneNumber)),
                                              );
                                            },
                                            child: const Text(
                                              "Forgot password",
                                              style: TextStyle(
                                                  fontSize: FontSizes.s12,
                                                  fontWeight:
                                                      FontWeights.semiBold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: AppColors.gold2),
                                            ))),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              PrimaryButton(
                                  label: "Sign in",
                                  onPressed: !_isDisable
                                      ? () async {
                                          setState(() {
                                            _isDisable = true;
                                            _isLoading = true;
                                          });
                                          if (!_isVisible) {
                                            // If password field is not visible, only verify the mobile number
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              final verification = await context
                                                  .read<VerifyMobileCubit>()
                                                  .verifyMobile(
                                                      phoneNumber ?? '');
                                              if (verification is DataFailed) {
                                                   setState((){
                                                      _isLoading = false;
                                                    });
                                                String errorMessage =
                                                    "Failed to verify user.";
                                                final error = verification
                                                    .error!.response!.data;
                                                if (error != null &&
                                                    error["error"] ==
                                                        "Invalid Contact Number") {
                                                  errorMessage =
                                                      "Contact number not registered.Please signup.";
                                                }
                                                showHoveringSnackbar(
                                                    context, errorMessage);
                                                 
                                              } else {
                                                setState(() {
                                                  // _isDisable = false;
                                                  _isVisible =
                                                      true; // Make password field visible
                                                  _isLoading = false;
                                                });
                                                // showHoveringSnackbar(context,
                                                //     "Mobile number verified. Please enter your password.");
                                              }
                                              setState(() {
                                                _isDisable = false;
                                           
                                              });
                                            }
                                          } else {
                                            // If password field is visible, proceed with login
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              await _login(
                                                  phoneNumber, password);
                                            }
                                          }
                                          setState(() {
                                            _isDisable = false;
                                          });
                                        }
                                      : () {},
                                  buttonStyleType: ButtonStyleType.filled),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: AppColors.textfieldColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text("Or sign up with",
                                        style: getTextfieldLabel()),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: AppColors.textfieldColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: !_isDisable
                                      ? () async {
                                          setState(() {
                                            _isDisable = true;
                                            _isLoading = true;
                                          });
                                          final verification = await context
                                              .read<VerifyMobileCubit>()
                                              .verifyMobile(phoneNumber ?? '');
                                          if (verification is DataSuccess) {
                                            String errorMessage =
                                                "User already registered. Please use a different phone number.";

                                            showHoveringSnackbar(
                                                context, errorMessage);
                                          } else {
                                            final response = await context
                                                .read<OtpCubit>()
                                                .sendOtp(phoneNumber ?? '', "");

                                            if (phoneNumber == null ||
                                                phoneNumber!.isEmpty) {
                                              showHoveringSnackbar(context,
                                                  "Please enter your mobile number");
                                            } else if (response is DataFailed) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              showHoveringSnackbar(context,
                                                  "Failed to send the otp.");
                                            } else {
                                              showHoveringSnackbar(context,
                                                  "Otp sent successfully!");
                                              Future.delayed(
                                                  Duration(seconds: 2));
                                              await GoRouter.of(context).pushNamed(
                                                  Routes.enterOtp,
                                                  extra: FlowTypeWrapperModel(
                                                      flowType: FlowType.signUp,
                                                      signUpModel: SignUpModel(
                                                          Phone: phoneNumber,
                                                          Country: _country,
                                                          CountryCode:
                                                              _countryCode)));
                                            }
                                          }
                                          setState(() {
                                            _isDisable = false;
                                            _isLoading = false;
                                          });
                                        }
                                      : () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 140,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2),
                                          child: Image.asset(
                                              "assets/images/sign_up_logo.png"),
                                        ),
                                      ),
                                      Gradients(
                                        text: "Sign up",
                                        style: gradientContentTextMedium,
                                        gradient: AppColors.accentColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Center(
                                  child: Text("Version ${appVersion}",
                                      style: getDateTimeLabel())),
                            ],
                          ),
                        ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

enum FlowType { fogotPassword, signUp, signIn }
