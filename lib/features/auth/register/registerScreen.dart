import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/bloc/auth/auth_cubit.dart';
import 'package:recipes/core/models/user_model.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/text_style.dart';
import 'package:recipes/core/resources/route_manger.dart';
import 'package:recipes/core/utils/ui_utils.dart';
import 'package:recipes/core/widgets/custom_button.dart';
import 'package:recipes/core/widgets/custom_text_form_field.dart';
import 'package:recipes/core/widgets/validators.dart';
import 'package:recipes/features/auth/widgets/custom_caroselslider.dart';
import 'package:recipes/features/auth/widgets/custom_navigator_button.dart';
import 'package:recipes/features/auth/widgets/switch_toggle.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  String selectedAvatar = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCarouselslider(
                  onImageSelected: (image){
                    selectedAvatar=image;
                  },
                ),
                SizedBox(height: 10.h),
                Text(
                  "Avatar",
                  style: AppTextStyles.buttonName(16.sp, ColorsManger.white),
                ),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  prefixIcon: Icons.person,
                  iconName: "Name",
                  controller: _nameController,
                  validator: (value) {
                    return AppValidators.validateFullName(_nameController.text);
                  },
                ),
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
                CustomTextFormField(
                  prefixIcon: Icons.lock,
                  iconName: "Password",
                  sufffixIcon: Icons.visibility,
                  controller: _passwordController,
                  validator: (value) {
                    return AppValidators.validatePassword(
                      _passwordController.text,
                    );
                  },
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  prefixIcon: Icons.lock,
                  iconName: "Confirm Password",
                  controller: _confirmPasswordController,
                  sufffixIcon: Icons.visibility,
                  validator: (value) {
                    return AppValidators.validateConfirmPassword(
                      _confirmPasswordController.text,
                      _passwordController.text,
                    );
                  },
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  prefixIcon: Icons.phone,
                  iconName: "Phone",
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  validator: (value) {
                    return AppValidators.validatePhoneNumber(
                      _phoneController.text,
                    );
                  },
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  buttonWidth: double.infinity,
                  buttonClick: () {
                    _createAccount();
                  },
                  backgroundColor: ColorsManger.yellow,
                  foregroundColor: ColorsManger.black,
                  buttonName: "Create Account",
                  buttonPaddingHight: 15,
                  style: AppTextStyles.buttonName(20.sp, ColorsManger.black),
                ),
                SizedBox(height: 18.h),
                CustomNavigatorButton(
                  statementTitle: "Already Have Account ?",
                  textButtonTitle: "Login",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, RoutesManger.login);
                  },
                ),
                SizedBox(height: 18),
                SwitchToggle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createAccount() async {
    if (_formKey.currentState!.validate() == false) return;
    try {
      UiUtils.showLoading(context, isDismiss: false);
      await context.read<AuthCubit>().register(
            UserModel(
              id: '',
              name: _nameController.text,
              email: _emailController.text,
              phoneNumber: _phoneController.text,
              poster: selectedAvatar,
            ),
            _passwordController.text,
          );
      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: "User Created Successfully",
        bgColor: Colors.green,
        fgColor: Colors.white,
      );
      Navigator.pushReplacementNamed(context, RoutesManger.login);
    } on FirebaseAuthException catch (exception) {
      UiUtils.hideDialog(context);
      if (exception.code == 'weak-password') {
        UiUtils.showMessage(
          message: 'The password provided is too weak.',
          bgColor: Colors.red,
          fgColor: Colors.white,
        );
      } else if (exception.code == 'email-already-in-use') {
        UiUtils.showMessage(
          message: 'The account already exists for that email.',
          bgColor: Colors.red,
          fgColor: Colors.white,
        );
      }
    } on FirebaseException catch (exception) {
      UiUtils.hideDialog(context);
      if (exception.code == 'permission-denied') {
        UiUtils.showMessage(
          message:
              'Account created, but profile save was denied by Firestore rules. Check rules deployment and collection name.',
          bgColor: Colors.red,
          fgColor: Colors.white,
        );
      } else {
        UiUtils.showMessage(
          message: exception.message ?? exception.code,
          bgColor: Colors.red,
          fgColor: Colors.white,
        );
      }
    } catch (exception) {
      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: exception.toString(),
        bgColor: Colors.red,
        fgColor: Colors.white,
      );
    }
  }
}
