import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl_mobile_field/country_picker_dialog.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';

import '../../core/constants/color_manager.dart';

class CustomMobileNumberPicker extends StatefulWidget {
  final Function(String) phoneNumber;
  final Function(String) country;
  final Function(String) countryCode;
  const CustomMobileNumberPicker(
      {super.key,
      required this.phoneNumber,
      required this.country,
      required this.countryCode});

  @override
  State<CustomMobileNumberPicker> createState() =>
      _CustomMobileNumberPickerState();
}

class _CustomMobileNumberPickerState extends State<CustomMobileNumberPicker> {
  final TextEditingController _controller = TextEditingController();
  Color _textColor = AppColors.secondaryColor;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        setState(() {
          _textColor = _controller.text.isNotEmpty
              ? AppColors.textfieldColor
              : AppColors.secondaryColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntlMobileField(
        fillColor: AppColors.tileColor,
        pickerDialogStyle: PickerDialogStyle(
            searchFieldPadding: const EdgeInsets.symmetric(horizontal: 10),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search country',
              hintStyle: TextStyle(color: AppColors.contentTextColor),
              // filled: true,
              // fillColor: Colors.transparent,
            )),
        key: const Key(""),
        // dropdownDecoration:
        // BoxDecoration(color: const Color.fromARGB(62, 255, 250, 234)),
        dropdownIcon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: AppColors.secondaryColor,
        ),
        controller: _controller,
        decoration: InputDecoration(
          counterStyle: const TextStyle(color: AppColors.secondaryColor),
          hintStyle: const TextStyle(color: AppColors.secondaryColor),
          focusColor: AppColors.textfieldColor,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20), // Changed AppPadding.p15 and AppPadding.p10
          floatingLabelBehavior: FloatingLabelBehavior.never,
          // suffixIcon: widget.iconButton,
          border: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: AppColors.secondaryColor), // Match the fillColor
            borderRadius: BorderRadius.circular(8),
          ),
          // hintText: widget.hint,
          // hintStyle: getTextfieldLabel(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1,
                color: Colors
                    .transparent), // Changed AppSize.s1 and AppColors.fielBorder to default values
            borderRadius: BorderRadius.circular(8), // Changed AppSize.s8 to 8
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1,
                color: AppColors
                    .textfieldColor), // Changed AppSize.s1 and AppColors.lowGrey to default values
            borderRadius: BorderRadius.circular(8), // Changed AppSize.s8 to 8
          ),
          errorStyle: getButtonLabelMedium(),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dropdownTextStyle: const TextStyle(
          color: AppColors.secondaryColor, // Update dropdown text color
        ),
        style: const TextStyle(
          color: AppColors.secondaryColor,
        ),
        initialCountryCode: 'IN',
        onChanged: (phone) {
          widget.phoneNumber(phone.completeNumber);
          widget.country(phone.countryISOCode);
          widget.countryCode(phone.countryCode);
        },
      ),
    );
  }
}
