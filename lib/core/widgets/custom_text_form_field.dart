import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.iconName,
    required this.prefixIcon,
    this.sufffixIcon,
    this.controller,
    this.validator,
    this.maxLength,
    this.keyboardType,
  });
  final String iconName;
  final IconData prefixIcon;
  final IconData? sufffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final dynamic maxLength;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.sufffixIcon != null;
    return TextFormField(
      style: TextStyle(color: ColorsManger.white),
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isPasswordField ? _obscure : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsManger.darkGray,
        label: Text(
          widget.iconName,
          style: AppTextStyles.buttonName(15.sp, ColorsManger.white),
        ),

        prefixIcon: Icon(widget.prefixIcon, color: ColorsManger.white),
        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: ColorsManger.white,
                ),
              )
            : (widget.sufffixIcon != null
                ? Icon(widget.sufffixIcon, color: ColorsManger.white)
                : null),
      ),
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
    );
  }
}
