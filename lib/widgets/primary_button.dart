import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Size size;
  final Color? backgroundColor;
  final void Function() onPressed;
  
  const PrimaryButton({super.key, required this.text, required this.onPressed, required this.size, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      minimumSize: size,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ), 
    child: Text(text, style: TextStyle(color: AppColors.whiteColor, fontSize: 20, fontWeight: FontWeight.bold),)
    );
  }
}