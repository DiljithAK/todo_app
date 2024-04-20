import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? fieldValidator;
  final TextInputType? keyboardType;
  final int maxLines;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.fieldValidator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: fieldValidator,
      ),
    );
  }
}
