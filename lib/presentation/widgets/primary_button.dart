import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import '../../core/constants/color_manager.dart';

enum ButtonStyleType { filled, filledSmall, disable }
enum ButtonState { normal, loading, success}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? textcolor;
  final ButtonStyleType buttonStyleType;
  final ButtonState? buttonState;
  
  const PrimaryButton(
      {required this.label,
      required this.onPressed,
      this.textcolor,
      this.width,
      this.height,
      super.key,
      required this.buttonStyleType,
      this.buttonState = ButtonState.normal});
      
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GradientElevatedButton(
        onPressed: onPressed,
        style: _getButtonStyle(),
        child: Container(
          width: _getWidth(),
          height: _getHeight(),
          alignment: Alignment.center,
          child: _buildChild(),
        ),
      ),
    );
  }
  
  Widget _buildChild() {
    switch (buttonState) {
      case ButtonState.loading:
        return const SizedBox(
          width: 24,
          height: 24,
          child: CupertinoActivityIndicator(
            color: Colors.black,
          ),
        );
      case ButtonState.success:
        return const Icon(
          Icons.check_circle_outline_sharp,
          color: Colors.black,
          size: 30,
        );
      case ButtonState.normal:
      default:
        return Text(
          label,
          style: buttonStyleType == ButtonStyleType.filled
              ? getLabelTextLarge()
              : getLabelTextMedium(),
        );
    }
  }
  
  GradientButtonStyle _getButtonStyle() {
    switch (buttonStyleType) {
      case ButtonStyleType.filled:
        return GradientElevatedButton.styleFrom(
          elevation: 1,
          gradient: AppColors.accentColor,
          textStyle: getLabelTextLarge(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      case ButtonStyleType.filledSmall:
        return GradientElevatedButton.styleFrom(
          elevation: 1,
          gradient: AppColors.accentColor,
          textStyle: getLabelTextMedium(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      case ButtonStyleType.disable:
        return GradientElevatedButton.styleFrom(
          elevation: 1,
          gradient: AppColors.accentColor,
          textStyle: getLabelTextMedium(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
    }
  }
  
  double? _getWidth() {
    if (buttonStyleType == ButtonStyleType.filledSmall) {
      return (width ?? 90);
    }
    return width;
  }
  
  double? _getHeight() {
    if (buttonStyleType == ButtonStyleType.filledSmall) {
      return (height ?? 25); // 75% of the default height
    }
    return height ?? 50;
  }
}
