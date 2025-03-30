import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/color_manager.dart';
import '../../core/constants/style_manager.dart';

// Enum to define box size
enum BoxSize { short, long }

class DatePicker extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String) onDateSelected;
  final String title;
  final String hint;
  final BoxSize boxSize;
  final bool enabled; // Add enabled property

  DatePicker({
    super.key,
    this.validator,
    this.onSaved,
    required this.onDateSelected,
    required this.title,
    required this.hint,
    this.boxSize = BoxSize.long,
    this.enabled = true, // Default to enabled
  });

  @override
  State<DatePicker> createState() => _DatePickerState();

  final TextEditingController controller = TextEditingController();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  bool _enabledays(DateTime day) {
    return day.isAfter(DateTime.now().subtract(const Duration(days: 1)));
  }

  Future<void> _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2050),
      selectableDayPredicate: _enabledays,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          // colorScheme: ColorScheme.light(
          //   primary: AppColors.navbarInactive,
          //   onPrimary: AppColors.secondaryColor,
          // ),
          dialogTheme: DialogTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            titleTextStyle: TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
            ),
            contentTextStyle: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  // backgroundColor: AppColors.airTicketContentColor,
                  )),
        ),
        child: child!,
      ),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.controller.text =
            DateFormat('dd MMM yyyy').format(selectedDate!);
        widget.onDateSelected(DateFormat('yyyy-MM-dd').format(selectedDate!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = widget.boxSize == BoxSize.short ? 165.0 : double.infinity;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: getContentTextLarge()),
          const SizedBox(height: 10),
          Container(
            width: boxWidth,
            child: TextFormField(
              validator: widget.validator,
              onSaved: (value) {
                if (selectedDate != null) {
                  widget.onSaved
                      ?.call(DateFormat('yyyy-MM-dd').format(selectedDate!));
                }
              },
              controller: widget.controller,
              readOnly: true,
              style: getTextfieldLabel(),
              cursorColor: AppColors.purple1,
              cursorWidth: 1,
              enabled:
                  widget.enabled, // Enable or disable based on passed value
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.tileColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: IconButton(
                    onPressed:
                        widget.enabled ? () => _showDatePicker(context) : null,
                    icon: const Icon(
                      Icons.calendar_month,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: selectedDate == null
                      ? widget.hint
                      : DateFormat('dd MMM yyyy').format(selectedDate!),
                  hintStyle: getTextfieldLabel(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.textfieldColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: AppColors.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: AppColors.secondaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorStyle: getButtonLabelMedium()),
            ),
          ),
        ],
      ),
    );
  }
}
