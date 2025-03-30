import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:bellagio_mobile_user/core/dependency_injection/service_locator.dart';
import 'package:bellagio_mobile_user/data/models/flow_type_model/flow_type_model.dart';
import 'package:bellagio_mobile_user/data/models/forgot_password_model/forgot_password_model.dart';
import 'package:bellagio_mobile_user/domain/usecases/forgot_password_usecase/forgot_password_usecase.dart';
import 'package:bellagio_mobile_user/presentation/pages/sign_in/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:bellagio_mobile_user/presentation/widgets/custom_textfield.dart';
import 'package:bellagio_mobile_user/presentation/widgets/primary_button.dart';
import 'package:bellagio_mobile_user/presentation/widgets/socials_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/style_manager.dart';
import '../../../core/storage/data_state.dart';
import '../../routes/routes.dart';
import '../../widgets/custom_snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final FlowTypeWrapperModel model;
  const ForgotPasswordScreen({super.key, required this.model});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password = "";
  String confirmPassword = "";
  bool _isDisable = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
          forgotPasswordUsecase: getIt.get<ForgotPasswordUsecase>()),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
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
                        text: "Forgot password",
                        style: gradientTitleTextLarge,
                        gradient: AppColors.accentColor,
                      ),
                      const SizedBox(height: 40),
                      CustomTextfield(
                        obscureText: true,
                        hint: "Enter your new password",
                        label: "New Password",
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
                      const SizedBox(height: 10),
                      CustomTextfield(
                        obscureText: true,
                        hint: "Re-enter your new password",
                        label: "Re-enter password",
                        onChanged: (value) {
                          confirmPassword = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter the password';
                          } else if (value != password) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 170,
                      ),
                      PrimaryButton(
                        label: "Submit",
                        onPressed: !_isDisable
                            ? () async {
                                setState(() {
                                  _isDisable = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  final model = ForgotPasswordModel(
                                      newPassword: password,
                                      confirmNewPassword: confirmPassword,
                                      mobileNumber:
                                          widget.model.mobileNumber ?? '');
                                  final result = await context
                                      .read<ForgotPasswordCubit>()
                                      .forgotPassword(model);
                                  if (result is DataFailed) {
                                    showHoveringSnackbar(
                                        context, "Failed to reset password.");
                                  } else {
                                    showHoveringSnackbar(context,
                                        "Reset password successfully!");
                                    GoRouter.of(context)
                                        .goNamed(Routes.signIn);
                                  }
                                }
                                setState(() {
                                  _isDisable = false;
                                });
                              }
                            : () {},
                        buttonStyleType: ButtonStyleType.filled,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
