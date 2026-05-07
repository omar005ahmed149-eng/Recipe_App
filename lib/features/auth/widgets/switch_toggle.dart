import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';

class SwitchToggle extends StatefulWidget {
  const SwitchToggle({super.key});

  @override
  State<SwitchToggle> createState() => _SwitchToggleState();
}

class _SwitchToggleState extends State<SwitchToggle> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManger.black,
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: ColorsManger.yellow, width: 2.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFlag(SvgManger.usa, 0),
          SizedBox(width: 8.w),
          _buildFlag(SvgManger.eg, 1),
        ],
      ),
    );
  }

  Widget _buildFlag(String imagePath, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? ColorsManger.yellow : Colors.transparent,
            width: 3.w,
          ),
        ),
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: SvgPicture.asset(
              imagePath,
              width: 40.w,
              height: 30.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
