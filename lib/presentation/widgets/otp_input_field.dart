import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../core/constants/color_manager.dart';

class OtpInputField extends StatelessWidget {
  final Function(int) otp;
  const OtpInputField({super.key, required this.otp});

  // Default Pin Theme
  PinTheme get defaultPinTheme => PinTheme(
        width: 55,
        height: 55,
        textStyle: getContentTextLarge(),
        decoration: BoxDecoration(
          color: AppColors.tileColor, // Add background color (fill color)
          borderRadius: BorderRadius.circular(8),
        ),
      );

  // Focused Pin Theme
  PinTheme get focusedPinTheme => defaultPinTheme.copyDecorationWith(
        border: Border.all(color: AppColors.secondaryColor),
        borderRadius: BorderRadius.circular(8),
      );

  // Submitted Pin Theme
  PinTheme get submittedPinTheme => defaultPinTheme.copyDecorationWith(
        color: AppColors.tileColor,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Center(
        child: Pinput(
          length: 6,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
                    onCompleted: (pin) {
            debugPrint('Entered OTP: $pin');
            otp(int.parse(pin)); // Pass the OTP to the parent widget
          },
        ),
      ),
    );
  }
}
