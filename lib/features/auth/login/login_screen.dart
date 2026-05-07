import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/bloc/auth/auth_cubit.dart';
import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';
import 'package:recipes/core/resources/route_manger.dart';
import 'package:recipes/core/utils/ui_utils.dart';
import 'package:recipes/core/widgets/custom_button.dart';
import 'package:recipes/core/widgets/custom_text_form_field.dart';
import 'package:recipes/core/widgets/validators.dart';
import 'package:recipes/features/auth/widgets/custom_divider.dart';
import 'package:recipes/features/auth/widgets/custom_navigator_button.dart';
import 'package:recipes/features/auth/widgets/custom_textButton.dart';
import 'package:recipes/features/auth/widgets/switch_toggle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 19),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(AssetsManger.logo),

                  CustomTextFormField(
                    prefixIcon: Icons.email,
                    iconName: "Email",
                    controller: _emailController,
                    validator: (value) {
                      return AppValidators.validateEmail(
                          _emailController.text);
                    },
                  ),
                  SizedBox(height: 22.h),
                  CustomTextFormField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    iconName: "Passowrd",
                    sufffixIcon: Icons.visibility,
                    validator: (value) {
                      return AppValidators.validatePassword(
                        _passwordController.text,
                      );
                    },
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextbutton(
                        text: "Forget Password ?",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManger.forgetPassProfile,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 33.h),
                  CustomButton(
                    buttonWidth: double.infinity,
                    buttonClick: () {
                      _login();
                    },
                    backgroundColor: ColorsManger.yellow,
                    foregroundColor: ColorsManger.black,
                    buttonName: "Login",
                    buttonPaddingHight: 15,
                    style: AppTextStyles.buttonName(20.sp, ColorsManger.black),
                  ),
                  SizedBox(height: 23.h),
                  CustomNavigatorButton(
                    statementTitle: "Don't Have Account ?",
                    textButtonTitle: "Create one",
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesManger.register,
                      );
                    },
                  ),
                  SizedBox(height: 28.h),
                  CustomDivider(),
                  SizedBox(height: 38.h),
                  CustomButton(
                    buttonWidth: double.infinity,
                    buttonClick: () {},
                    backgroundColor: ColorsManger.yellow,
                    foregroundColor: ColorsManger.black,
                    buttonName: "Login With Google",
                    icon: SvgManger.iconGoogle,
                    isIcon: true,
                    buttonPaddingHight: 15,
                    iconSpace: 3.w,
                    style:
                        AppTextStyles.buttonName(16.sp, ColorsManger.black),
                  ),
                  SizedBox(height: 34.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate() == false) return;

    try {
      UiUtils.showLoading(context);
      final user = await context.read<AuthCubit>().login(
            email: _emailController.text,
            password: _passwordController.text,
          );
      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: "User Logged-In Successfully",
        bgColor: Colors.green,
        fgColor: Colors.white,
      );
      Navigator.pushReplacementNamed(context, RoutesManger.mainlayout);
    } on FirebaseAuthException catch (exception) {
      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: "Wrong email or password",
        bgColor: Colors.red,
        fgColor: Colors.white,
      );
    }
  }
}
