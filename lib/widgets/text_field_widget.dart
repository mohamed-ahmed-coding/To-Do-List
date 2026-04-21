import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.icon,
    this.maxLines,
    required this.obscureText,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          maxLines: maxLines ?? 1,
                          controller: controller,
                          focusNode: focusNode,
                          obscureText: obscureText,
                          style: TextStyle(color: AppColors.blackColor, fontSize: 18),
                          decoration: InputDecoration(
                            hintText: hintText,
                            prefixIcon: Icon(icon, color: AppColors.primaryColor),
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColors.blackColor, width: 1),
                            ),
                          ),
                        ),
                      );
  }
}