import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';

class ThemeManger {
  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManger.black,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManger.black,
      foregroundColor: ColorsManger.yellow,
      centerTitle: true,
      titleTextStyle: AppTextStyles.buttonName(16.sp, ColorsManger.yellow),
    ),
    dividerTheme: DividerThemeData(color: ColorsManger.yellow),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManger.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManger.red, width: 1.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManger.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManger.yellow,
        unselectedItemColor: ColorsManger.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      )
  );
}
