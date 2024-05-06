import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/colors.dart';

class SubmitButton extends StatelessWidget {
  final double? width;
  final double? height;
  final void Function()? onBtnPress;
  final String btnText;

  const SubmitButton({
    super.key,
    this.width,
    this.height,
    this.onBtnPress,
    this.btnText = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onBtnPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors().paleBlue,
          foregroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          btnText,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
