import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? fieldValidator;
  final bool isObscure;
  final void Function()? eyeBtnonPress;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.fieldValidator,
    required this.isObscure,
    this.eyeBtnonPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors().appWhite,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        suffixIcon: IconButton(
          iconSize: 18,
          color: Colors.grey[600],
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: eyeBtnonPress,
        ),
      ),
      validator: fieldValidator,
    );
  }
}
