import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';

class TabBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TabBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
    isSelected ? const Color(0xFFF5A623) : const Color(0xFF888888);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Icon(icon, color: color, size: 42.sp),
               SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 20.sp,
                  fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
           SizedBox(height: 8.h),
          if (isSelected)
            Container(
              height: 2.5.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: ColorsManger.yellow,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
        ],
      ),
    );
  }
}
