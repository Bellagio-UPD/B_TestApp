import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final String hint;
  final List<T>? items;
  //  final List<T>? dataList;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    this.items,
    // this.dataList,
    this.selectedValue,
    required this.onChanged,
    this.validator,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.selectedValue ?? widget.items!.first ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.label, style: getContentTextLarge()),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            iconEnabledColor: AppColors.secondaryColor,
            value: _currentValue,
            items: widget.items!
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: getTextfieldLabel()),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
              widget.onChanged(value);
            },
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.tileColor,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              // hintText: widget.hint,
              // hintStyle: getTextfieldLabel(),
              errorStyle: getButtonLabelMedium(),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.textfieldColor),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            dropdownColor: AppColors.navbarColor,
          ),
        ],
      ),
    );
  }
}
