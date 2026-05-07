import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes/core/bloc/auth/auth_cubit.dart';

import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/route_manger.dart';

import '../../core/bloc/reciepes/reciepes_cubit.dart';
import '../../core/bloc/reciepes/reciepes_state.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late String _selectedPoster;
  late final String _initialName;
  late final String _initialPhone;
  bool _isEditMode = false;
  bool _isSaving = false;
  bool _isDeleting = false;

  static const List<String> _avatars = [
    AssetsManger.avatarOne,
    AssetsManger.avatarTwo,
    AssetsManger.avatarThree,
    AssetsManger.avatarFour,
    AssetsManger.avatarFive,
    AssetsManger.avatarSix,
    AssetsManger.avatarSeven,
    AssetsManger.avatarEight,
    AssetsManger.avatarNine,
  ];

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.user;
    _initialName = (user?.name ?? '').trim();
    _initialPhone = (user?.phoneNumber ?? '').trim();
    _nameCtrl = TextEditingController(text: _initialName);
    _phoneCtrl = TextEditingController(text: _initialPhone);

    final appPoster = context.read<ReciepesCubit>().state.selectedPoster;
    final userPoster = user?.poster ?? '';
    if (_avatars.contains(appPoster)) {
      _selectedPoster = appPoster;
    } else if (_avatars.contains(userPoster)) {
      _selectedPoster = userPoster;
    } else {
      _selectedPoster = AssetsManger.avatarOne;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final previousName = _initialName;
    final previousPhone = _initialPhone;

    final name = _nameCtrl.text.trim().isNotEmpty
        ? _nameCtrl.text.trim()
        : previousName;
    final phone = _phoneCtrl.text.trim().isNotEmpty
        ? _phoneCtrl.text.trim()
        : previousPhone;

    if (name.isEmpty && previousName.isEmpty) {
      _showSnack('Name cannot be empty', isError: true);
      return;
    }

    setState(() => _isSaving = true);

    try {
      final currentUser = context.read<AuthCubit>().state.user;
      if (currentUser != null) {
        currentUser.name = name;
        currentUser.phoneNumber = phone;
        currentUser.poster = _selectedPoster;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.id)
            .update({
          'name': name,
          'phoneNumber': phone,
          'poster': _selectedPoster,
        });
        context.read<AuthCubit>().updateCurrentUser(currentUser);
      }

      context.read<ReciepesCubit>().setPoster(_selectedPoster);

      _showSnack('Profile updated!');
      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showSnack('Error saving: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _onPrimaryButtonPressed() {
    if (_isSaving || _isDeleting) return;
    if (_isEditMode) {
      _saveChanges();
      return;
    }
    setState(() => _isEditMode = true);
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorsManger.darkGray,
        title: const Text('Delete Account',
            style: TextStyle(color: Colors.white)),
        content: const Text(
            'This will permanently delete your account and all data. Are you sure?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isDeleting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user?.uid;

      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .delete();

        await user!.delete();
      }

      context.read<ReciepesCubit>().clearAll();
      await context.read<AuthCubit>().logout();

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesManger.login, (r) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        _showSnack('Please log out and log in again to delete your account.',
            isError: true);
      } else {
        _showSnack('Error: ${e.message}', isError: true);
      }
    } catch (e) {
      _showSnack('Error deleting account: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? ColorsManger.red : ColorsManger.darkGray,
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.black,
      appBar: AppBar(
        backgroundColor: ColorsManger.black,
        centerTitle: true,
        title: Text(
          'Pick Avatar',
          style: GoogleFonts.roboto(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManger.yellow),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new,
              color: ColorsManger.yellow),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),

            BlocBuilder<ReciepesCubit, ReciepesState>(
              builder: (context, _) {

                return Center(
                  child: ClipOval(
                    child: SizedBox(
                      width: 110.r,
                      height: 110.r,
                      child: _selectedPoster.isNotEmpty
                          ? Image.asset(_selectedPoster, fit: BoxFit.cover)
                          : Container(
                              color: const Color(0xFF3A8DDE),
                              child: Icon(Icons.person,
                                  size: 60.r, color: Colors.white),
                            ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 24.h),

            _InputField(
              controller: _nameCtrl,
              hint: 'John Safwat',
              icon: Icons.person_outline,
            ),

            SizedBox(height: 12.h),

            _InputField(
              controller: _phoneCtrl,
              hint: '01200000000',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              maxLength: 11,
            ),

                      SizedBox(height: 14.h),

                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, RoutesManger.forgetPassProfile),
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),

                      if (_isEditMode) ...[
                        SizedBox(height: 28.h),
                        Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: ColorsManger.darkGray,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12.w,
                              mainAxisSpacing: 12.h,
                            ),
                            itemCount: _avatars.length,
                            itemBuilder: (_, i) {
                              final isSelected = _avatars[i] == _selectedPoster;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedPoster = _avatars[i]),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? ColorsManger.yellow
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                    color: isSelected
                                        ? ColorsManger.yellow.withOpacity(0.15)
                                        : Colors.transparent,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.asset(_avatars[i], fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),


              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: (_isDeleting || _isSaving) ? null : _deleteAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManger.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                    elevation: 0,
                  ),
                  child: _isDeleting
                      ? SizedBox(
                          width: 22.r,
                          height: 22.r,
                          child: const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : Text('Delete Account',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ),
              ),

              SizedBox(height: 12.h),

              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: (_isSaving || _isDeleting) ? null : _onPrimaryButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManger.yellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? SizedBox(
                          width: 22.r,
                          height: 22.r,
                          child: const CircularProgressIndicator(
                              color: Colors.black, strokeWidth: 2),
                        )
                      : Text(
                          _isEditMode ? 'Save Data' : 'Update Data',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700),
                        ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}


class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int? maxLength;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManger.darkGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: maxLength != null
            ? [LengthLimitingTextInputFormatter(maxLength)]
            : null,
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white54, size: 20.r),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          counterText: '',
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }
}
