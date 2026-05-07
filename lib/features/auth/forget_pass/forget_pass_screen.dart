import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';
import 'package:recipes/core/utils/ui_utils.dart';
import 'package:recipes/core/widgets/custom_button.dart';
import 'package:recipes/core/widgets/custom_text_form_field.dart';
import 'package:recipes/core/widgets/validators.dart';
import 'package:recipes/firebase/firebase_services.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password")),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(AssetsManger.forgetPass),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  prefixIcon: Icons.email,
                  iconName: "Email",
                  controller: _emailController,
                  validator: (value) {
                    return AppValidators.validateEmail(_emailController.text);
                  },
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  buttonWidth: double.infinity,
                  buttonClick: () {
                    _reset();
                  },
                  backgroundColor: ColorsManger.yellow,
                  foregroundColor: ColorsManger.black,
                  buttonName: "Verify Email",
                  buttonPaddingHight: 15,
                  style: AppTextStyles.buttonName(20.sp, ColorsManger.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _reset() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      UiUtils.showLoading(context);
      await FirebaseService.resetPassword(_emailController.text);
      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: "Password reset link sent to your email",
        bgColor: Colors.green,
        fgColor: ColorsManger.white,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (exception) {
      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: "Something went wrong",
        bgColor: Colors.red,
        fgColor: Colors.white,
      );
    }
  }
}
