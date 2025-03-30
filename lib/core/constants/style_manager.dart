import 'package:bellagio_mobile_user/core/constants/app_gradients.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/font_manager.dart';
import 'package:flutter/cupertino.dart';

// Solid color text styles
TextStyle _getTextStyle(
    double fontsize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontFamily: FontConstants.fontFamily,
      fontSize: fontsize,
      fontWeight: fontWeight,
      color: color);
}

// label texts
TextStyle getLabelTextLarge({double fontsize = FontSizes.s20, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.textColor);
}

TextStyle getLabelTextMedium({double fontsize = FontSizes.s14, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.textColor);
}

TextStyle getLabelTextSmall({double fontsize = FontSizes.s10, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.medium,
      AppColors.secondaryColor);
}

// title texts
TextStyle getTitleText({double fontsize = FontSizes.s20, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.secondaryColor);
}

// button label
TextStyle getButtonLabelMedium(
    {double fontsize = FontSizes.s12, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.medium,
      AppColors.secondaryColor);
}

// content texts

TextStyle getTileTitleLarge({double fontsize = FontSizes.s24, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.textColor);
}

TextStyle getTilePrice({double fontsize = FontSizes.s24, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.bold,
      AppColors.textColor);
}

TextStyle getContentTextLarge({double fontsize = FontSizes.s16, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.secondaryColor);
}

TextStyle getContentTextMedium(
    {double fontsize = FontSizes.s12, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.secondaryColor);
}

TextStyle getContentTextSmall({double fontsize = FontSizes.s14, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.medium,
      AppColors.secondaryColor);
}

TextStyle getTextfieldLabel({double fontsize = FontSizes.s14, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.textfieldColor);
}

TextStyle getDateTimeLabel({double fontsize = FontSizes.s12, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.dateTimeColor);
}

// individual texts
TextStyle getText({required double fontsize, required Color color}) {
  return _getTextStyle(
      fontsize, FontConstants.fontFamily, FontWeights.semiBold, color);
}

// air ticket card texts

TextStyle getAirTicketTitleLarge(
    {double fontsize = FontSizes.s30, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.textColor);
}

TextStyle getAirTicketContentMedium(
    {double fontsize = FontSizes.s12, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.medium,
      AppColors.airTicketContentColor);
}

// nav bar colors
TextStyle getNavbarSelected({double fontsize = FontSizes.s10, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.navbarActive);
}

TextStyle getNavbarUnselected({double fontsize = FontSizes.s10, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.navbarInactive);
}

// link color
TextStyle getLinkTextSmall(
    {double fontsize = FontSizes.s12,
    Color? color,
    required TextDecoration decoration}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.semiBold,
      AppColors.gold2);
}

TextStyle getLoyaltyCardUsername(
    {double fontsize = FontSizes.s10, Color? color}) {
  return _getTextStyle(fontsize, FontConstants.fontFamily, FontWeights.bold,
      AppColors.secondaryColor);
}

// Gradient text styles

TextStyle gradientTitleTextLarge = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: FontSizes.s32,
    fontWeight: FontWeights.semiBold);
TextStyle gradientTitleTextMedium =
    const TextStyle(fontSize: FontSizes.s24, fontWeight: FontWeights.semiBold);
TextStyle gradientContentTextLarge =
    const TextStyle(fontSize: FontSizes.s20, fontWeight: FontWeights.semiBold);
TextStyle gradientContentTextMedium =
    const TextStyle(fontSize: FontSizes.s16, fontWeight: FontWeights.semiBold);
TextStyle gradientLoyaltyCardPoints =
    const TextStyle(fontSize: FontSizes.s14, fontWeight: FontWeights.medium);

TextStyle gradientLoyaltyCardDescription =
    const TextStyle(fontSize: FontSizes.s12, fontWeight: FontWeights.semiBold);
