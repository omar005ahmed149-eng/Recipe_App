import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(indent: 60)),
        SizedBox(width: 10.w),
        Text("OR", style: AppTextStyles.buttonName(15, ColorsManger.yellow)),
        SizedBox(width: 10.w),
        Expanded(child: Divider(endIndent: 60)),
      ],
    );
  }
}
