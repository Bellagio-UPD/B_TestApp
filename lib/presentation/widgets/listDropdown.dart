import 'package:flutter/material.dart';
import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';

class DropDownList<T> extends StatefulWidget {
  final String label;
  final String hint;
  final List<T>? dataList;
  final String Function(T)? displayText;
  final Widget? Function(T)?
      customDecorator; // Added for custom decorators like stars
  final void Function(T)? onChanged;
  final bool readOnly;
  final String? selectedItem;
  final String? Function(String?)? validator;

  const DropDownList({
    Key? key,
    required this.label,
    required this.hint,
    required this.dataList,
    required this.displayText,
    this.customDecorator, // Optional decorator for items
    required this.onChanged,
    this.readOnly = false,
    this.selectedItem,
    this.validator,
  }) : super(key: key);

  @override
  _DropDownListState<T> createState() => _DropDownListState<T>();
}

class _DropDownListState<T> extends State<DropDownList<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.dataList != null && widget.displayText != null) {
      try {
        _selectedItem = widget.dataList!.firstWhere(
          (item) => widget.displayText!(item) == widget.selectedItem,
        );
      } catch (e) {
        _selectedItem = null;
      }
    } else {
      _selectedItem = null;
    }
  }
@override
  void didUpdateWidget(covariant DropDownList<T> oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (widget.dataList != oldWidget.dataList || widget.selectedItem != oldWidget.selectedItem) {
    try {
      _selectedItem = widget.dataList!.firstWhere(
        (item) => widget.displayText!(item).trim() == widget.selectedItem?.trim(),
        orElse: () => null as T,
      );
    } catch (e) {
      _selectedItem = null;
    }
    setState(() {});
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: getContentTextLarge()),
          const SizedBox(height: 10),
          DropdownButtonFormField<T>(
            iconEnabledColor: AppColors.secondaryColor,
            iconDisabledColor: AppColors.dateTimeColor,
            hint: Text(widget.hint, style: getTextfieldLabel()),
            value: _selectedItem,
            items: widget.dataList?.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.displayText!(item),
                      style: getTextfieldLabel(),
                    ),
                    // Use custom decorator if provided
                    if (widget.customDecorator != null)
                      widget.customDecorator!(item) ?? const SizedBox(),
                    const SizedBox(width: 8), // Spacing between star and text
                  ],
                ),
              );
            }).toList(),
            onChanged: widget.readOnly
                ? null
                : (T? newValue) {
                    setState(() {
                      _selectedItem = newValue;
                    });
                    if (newValue != null && widget.onChanged != null) {
                      widget.onChanged!(newValue);
                    }
                  },
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(
                  value != null ? widget.displayText!(value) : null,
                );
              }
              if (value == null) {
                return 'Please select a valid ${widget.label.toLowerCase()}';
              }
              return null;
            },
            decoration: InputDecoration(
              errorStyle: getButtonLabelMedium(),
              filled: true,
              fillColor: AppColors.tileColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              floatingLabelBehavior: FloatingLabelBehavior.never,
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
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.textfieldColor,
                ),
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
