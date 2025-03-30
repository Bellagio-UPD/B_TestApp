import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/color_manager.dart';
import '../../core/constants/style_manager.dart';
import 'custom_date_picker.dart';

class TimePicker extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String) onTimeSelected;
  final BoxSize boxSize;

  TimePicker({
    super.key,
    this.validator,
    this.onSaved,
    required this.onTimeSelected,
    this.boxSize = BoxSize.long
  });

  @override
  State<TimePicker> createState() => _TimePickerState();

  final TextEditingController controller = TextEditingController();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;

  Future<void> _showTimePicker(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        widget.controller.text = pickedTime.format(context); // Update the text
        widget.onTimeSelected(pickedTime.format(context)); // Callback
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = widget.boxSize == BoxSize.short ? 165.0 : double.infinity;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: boxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Time", style: getContentTextLarge()),
          const SizedBox(height: 10),
          TextFormField(
            validator: widget.validator,
            onSaved: (value) {
              if (selectedTime != null) {
                widget.onSaved?.call(DateFormat('HH:mm').format(DateTime(
                    0, 0, 0, selectedTime!.hour, selectedTime!.minute)));
              }
            },
            controller: widget.controller,
            readOnly: true,
            style: getTextfieldLabel(),
            cursorColor: AppColors.secondaryColor,
            cursorWidth: 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.tileColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: IconButton(
                onPressed: () {
                  _showTimePicker(context);
                },
                icon: const Icon(
                  Icons.access_time,
                  color: AppColors.secondaryColor,
                ),
              ),
              border: InputBorder.none,
              hintText: selectedTime == null
                  ? 'Select time'
                  : selectedTime!.format(context),
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
                borderSide: const BorderSide(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              errorStyle: getButtonLabelMedium()
            ),
          ),
        ],
      ),
    );
  }
}
