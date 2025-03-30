import 'dart:ffi';

import 'package:bellagio_mobile_user/core/constants/color_manager.dart';
import 'package:bellagio_mobile_user/core/constants/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String? hint;
  final String label;
  final IconButton? iconButton;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool obscureText;
  final bool readOnly;
  final String? initialValue;
  final String? value;
  final int? maxLines;
  final TextEditingController? textEditingController;
  CustomTextfield({
    super.key,
    this.hint,
    required this.label,
    this.iconButton,
    this.obscureText = false,
    this.inputType,
    this.initialValue,
    this.validator,
    this.readOnly = false,
    this.onSaved,
    this.onChanged,
    this.value,
    this.textInputAction,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.textEditingController
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final TextEditingController _controller = TextEditingController();
  late bool _obscureText;
  Color _textColor = AppColors.secondaryColor;
  TextStyle _textStyle = getTextfieldLabel();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    // Set an initial value if provided
    if (widget.value != null && widget.textEditingController == null) {
      _controller.value = TextEditingValue(text: widget.value!);
    }

    // Set a listener for text changes
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        setState(() {
          _textColor = AppColors.textfieldColor;
          _textStyle = getTextfieldLabel();
        });
      }
      // Trigger the onChanged callback
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: getContentTextLarge()),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: widget.maxLines,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            obscureText: _obscureText,
            cursorColor: AppColors.secondaryColor,
            cursorWidth: 1,
            controller: _controller,
            keyboardType: widget.inputType,
            readOnly: widget.readOnly,
            validator: widget.validator,
            onSaved: widget.onSaved,
            style: getTextfieldLabel(),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.tileColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: widget.obscureText
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                          color: AppColors.textfieldColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    )
                  : widget.iconButton,
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: getTextfieldLabel(),
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
              errorStyle: getButtonLabelMedium(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
