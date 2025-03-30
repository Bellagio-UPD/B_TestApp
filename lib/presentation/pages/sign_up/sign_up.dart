import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/data/models/flow_type_model/flow_type_model.dart';
import 'package:bellagio_mobile_user/data/models/sign_up_model/sign_up_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/sign_up_usecase/sign_up_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/sign_in.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_up/sign_up_cubit/sign_up_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:bellagio_mobile_user/presentation/widgets/socials_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/style_manager.dart';
import '../../../core/dependency_injection/service_locator.dart';
import '../../../core/storage/data_state.dart';
import '../../../core/storage/shared_pref_manager.dart';
import '../../../domain/usecases/user_info_usecase/user_info_usecase.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_snackbar.dart';
import '../home/home_screen_cubit/user_info_cubit.dart';
import '../video_player/video_player.dart';

class SignUp extends StatefulWidget {
  final FlowTypeWrapperModel flowTypeWrapperModel;
  const SignUp({super.key, required this.flowTypeWrapperModel});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isChecked = false;
  bool _isDisabled = false;
  bool _isLoading = false;
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';
  String? bellagioId = "";
  late SignUpCubit _signUpCubit;
  final _formKey = GlobalKey<FormState>();
  RegExp stringValidation = RegExp(r'^[a-zA-Z\s]+$');
  RegExp intValidation = RegExp(r'^\d+$');
  RegExp emailValidation =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  late VideoPlayerController _controller;

  bool get isChecked => _isChecked;
  set isChecked(bool value) {
    _isChecked = value;
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  Future<void> initialise() async {
    _signUpCubit = SignUpCubit(signUpUsecase: getIt.get<SignUpUsecase>());
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
        await sharedPrefManager.saveUserName(userName ?? "");
        await sharedPrefManager.saveUserId(userId);

        await _fetchUserInfo();

        GoRouter.of(context).goNamed(
          Routes.videoPlayerScreen,
          extra: 'assets/videos/LandingVideo-Ballagio.mp4',
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        showHoveringSnackbar(context, "Login successful, but user is null.");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Future<void> _fetchUserInfo() async {
    final userInforesponse = await context.read<UserInfoCubit>()
      ..fetchUserInfo();

    await Future.delayed(const Duration(seconds: 3)); // Simulate API delay

    final userInfoState = await context.read<UserInfoCubit>().state;

    if (userInfoState.userInfoModel != null) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignUpCubit(signUpUsecase: getIt.get<SignUpUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              UserInfoCubit(userInfoUsecase: getIt.get<UserInfoUsecase>()),
        ),
      ],
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                      const BoxDecoration(gradient: AppColors.backgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.13,
                            ),
                            Gradients(
                              text: "Sign up",
                              style: gradientTitleTextLarge,
                              gradient: AppColors.accentColor,
                            ),
                            const SizedBox(height: 30),
                            CustomTextfield(
                              hint: "Enter your first name",
                              label: "First name",
                              onChanged: (value) {
                                firstname = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter firstname';
                                } else if (!stringValidation.hasMatch(value)) {
                                  return "Please enter a valid firstname";
                                }
                                return null;
                              },
                            ),
                            CustomTextfield(
                              hint: "Enter your last name",
                              label: "Last name",
                              onChanged: (value) {
                                lastname = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter lastname';
                                } else if (!stringValidation.hasMatch(value)) {
                                  return "Please enter a valid lastname";
                                }
                                return null;
                              },
                            ),
                            // SizedBox(height: 10),
                            CustomTextfield(
                              hint: "Enter your email",
                              label: "Email",
                              onChanged: (value) {
                                email = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                } else if (!emailValidation.hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),
                            // SizedBox(height: 10),
                            CustomTextfield(
                              hint: "Enter your password",
                              label: "Password",
                              obscureText: true,
                              onChanged: (value) {
                                password = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the password';
                                } else if (value.length < 6) {
                                  return "Password must contain minimum 6 characters";
                                }
                                return null;
                              },
                            ),
                            // CustomTextfield(
                            //   hint: "Enter your bellagio id",
                            //   label: "Bellagio id",
                            //   onChanged: (value) {
                            //     bellagioId = value!;
                            //   },
                            // ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  },
                                  side: const BorderSide(
                                      color: AppColors.secondaryColor),
                                  // focusColor: AppColors.secondaryColor,
                                  activeColor: AppColors.secondaryColor,
                                  checkColor: AppColors.gold1,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: getText(
                                          fontsize: FontSizes.s12,
                                          color: AppColors.secondaryColor),
                                      children: [
                                        const TextSpan(
                                          text:
                                              "By signing up you agree with the ",
                                        ),
                                        TextSpan(
                                          text: "Terms and services",
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColors.gold2,
                                            fontWeight: FontWeights.semiBold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                        const TextSpan(text: " and "),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColors.gold2,
                                            fontWeight: FontWeights.semiBold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            PrimaryButton(
                                label: _isChecked ? "Submit" : "Sign up",
                                onPressed: _isChecked
                                    ? () async {
                                        setState(() {
                                          _isChecked = true;
                                          // _isDisabled = true;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          final mobile = widget
                                              .flowTypeWrapperModel
                                              .signUpModel!
                                              .Phone!
                                              .replaceAll("+", "0");
                                          final signUpModel = SignUpModel(
                                              ProfileImage: "N/A",
                                              CustomerId: "",
                                              FirstName: firstname,
                                              LastName: lastname,
                                              Email: email,
                                              FBEmail: "${mobile}@bellagio.com",
                                              Password: password,
                                              Phone: widget.flowTypeWrapperModel
                                                  .signUpModel!.Phone,
                                              Country: widget
                                                  .flowTypeWrapperModel
                                                  .signUpModel!
                                                  .Country,
                                              CountryCode: widget
                                                  .flowTypeWrapperModel
                                                  .signUpModel!
                                                  .CountryCode,
                                              BellagioId: bellagioId ?? '');
                                          final response = await context
                                              .read<SignUpCubit>()
                                              .createUser(signUpModel);

                                          if (response is DataFailed) {
                                            final error =
                                                response.error!.response!.data;
                                            final errorMsg =
                                                error?['error']?.toString();
                                            if (errorMsg != null &&
                                                errorMsg.contains("unique")) {
                                              if (errorMsg
                                                  .contains("BellagioId")) {
                                                showHoveringSnackbar(context,
                                                    "Bellagio Id already exists.");
                                                GoRouter.of(context)
                                                    .goNamed(Routes.signIn);
                                              } else if (errorMsg
                                                  .contains("Email")) {
                                                showHoveringSnackbar(context,
                                                    "Email already exists.");
                                                GoRouter.of(context)
                                                    .goNamed(Routes.signIn);
                                              } else {
                                                showHoveringSnackbar(context,
                                                    "Failed creating user.");
                                                GoRouter.of(context)
                                                    .goNamed(Routes.signIn);
                                              }
                                            } else {
                                              showHoveringSnackbar(context,
                                                  "Failed creating user.");
                                              GoRouter.of(context)
                                                  .goNamed(Routes.signIn);
                                            }

                                            setState(() {
                                              _isLoading = false;
                                            });
                                          } else {
                                            await _login(
                                                widget.flowTypeWrapperModel
                                                    .signUpModel!.Phone,
                                                password);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        }
                                      }
                                    : () {},
                                buttonStyleType: ButtonStyleType.filled),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: getText(
                                      fontsize: FontSizes.s12,
                                      color: AppColors.secondaryColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    GoRouter.of(context).goNamed(Routes.signIn);
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: FontSizes.s12,
                                        fontWeight: FontWeights.semiBold,
                                        decoration: TextDecoration.underline,
                                        color: AppColors.gold2),
                                  ),
                                )
                              ],
                            ),
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
              ]),
            ),
          );
        },
      ),
    );
  }
}
