import 'package:flutter/material.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/constants/style_manager.dart';

class CustomRadioButtonList extends StatefulWidget {
  final String label; // Title for the radio button list
  final List<String> options; // List of options to display
  final void Function(String?)?
      onChanged; // Callback for when the value changes
  final String? selectedValue; // Initial selected value

  const CustomRadioButtonList({
    Key? key,
    required this.label,
    required this.options,
    this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  _CustomRadioButtonListState createState() => _CustomRadioButtonListState();
}

class _CustomRadioButtonListState extends State<CustomRadioButtonList> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue; // Set initial value if provided
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: getContentTextLarge(),
        ),
        const SizedBox(height: 10),
        Column(
          children: widget.options.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue = option;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(option);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Icon(
                      _selectedValue == option
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: _selectedValue == option
                          ? AppColors.gold1
                          : AppColors.textfieldColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      option,
                      style: getTextfieldLabel(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
