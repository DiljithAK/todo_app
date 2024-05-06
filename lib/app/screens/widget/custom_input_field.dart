import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? fieldValidator;
  final TextInputType? keyboardType;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.fieldValidator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors().appWhite,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
      validator: fieldValidator,
    );
  }
}
