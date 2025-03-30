import 'package:flutter/material.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';

class DateTimePicker extends StatefulWidget {
  final void Function(String dateTime) onDateTimeSelected;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const DateTimePicker({
    Key? key,
    required this.onDateTimeSelected,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  String selectedDate = '';
  String selectedTime = '';

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate =
            '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
      });
      _emitDateTime();
    }
  }

  void _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime =
            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      });
      _emitDateTime();
    }
  }

  void _emitDateTime() {
    if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
      final dateTime = '$selectedDate $selectedTime';
      widget.onDateTimeSelected(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date and Time',
            style: getContentTextLarge(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.tileColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedDate.isEmpty ? 'Select Date' : selectedDate,
                      style: selectedDate.isEmpty
                          ? getTextfieldLabel()
                          : getTextfieldLabel(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: _pickTime,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.tileColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedTime.isEmpty ? 'Select Time' : selectedTime,
                      style: selectedTime.isEmpty
                          ? getTextfieldLabel()
                          : getTextfieldLabel(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (widget.validator != null)
            Text(
              widget.validator!('$selectedDate $selectedTime') ?? '',
              style: getButtonLabelMedium()
            ),
        ],
      ),
    );
  }
}
