import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';

class CustomTextbutton extends StatelessWidget {
  const CustomTextbutton({super.key, required this.onTap, required this.text});
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: AppTextStyles.buttonName(14.sp, ColorsManger.yellow),
      ),
    );
  }
}
