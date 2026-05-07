import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';
import 'package:recipes/core/widgets/custom_button.dart';
import 'onboarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  final OnBoardingModel model;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnBoardingItem({
    super.key,
    required this.model,
    required this.isLast,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(model.image, fit: BoxFit.cover),
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87, Colors.black],
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: REdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: ColorsManger.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManger.white,
                  ),
                ),

                SizedBox(height: 12.h),

                Text(
                  model.subtitle ?? " ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.sp, color: Colors.white70),
                ),

                SizedBox(height: 20.h),

                CustomButton(
                  buttonWidth: double.infinity,
                  buttonClick: onNext,
                  backgroundColor: ColorsManger.yellow,
                  foregroundColor: ColorsManger.black,
                  buttonName: isLast ? "Finish" : "Next",
                  buttonPaddingHight: 16,
                  style: AppTextStyles.buttonName(20.sp, ColorsManger.black),
                ),

                SizedBox(height: 12.h),

                OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorsManger.yellow),
                    minimumSize: Size(double.infinity, 50.sp),
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(color: ColorsManger.yellow),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
