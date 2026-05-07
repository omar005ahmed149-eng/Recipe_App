import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';
import 'package:recipes/features/auth/widgets/custom_textButton.dart';

class CustomNavigatorButton extends StatelessWidget {
  const CustomNavigatorButton({
    super.key,
    required this.statementTitle,
    required this.textButtonTitle,
    required this.onTap,
  });
  final String statementTitle;
  final String textButtonTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          statementTitle,
          style: AppTextStyles.buttonName(14.sp, ColorsManger.white),
        ),
        CustomTextbutton(onTap: onTap, text: textButtonTitle),
      ],
    );
  }
}
