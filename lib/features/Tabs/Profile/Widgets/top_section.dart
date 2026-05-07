import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/bloc/auth/auth_cubit.dart';

import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/core/resources/route_manger.dart';
import 'package:recipes/features/Tabs/Profile/Widgets/TabBar_Item.dart';
import '../../../../core/bloc/reciepes/reciepes_cubit.dart';
import '../../../../core/bloc/reciepes/reciepes_state.dart';
import 'Stat_Item.dart';

class TopSection extends StatefulWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const TopSection({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  void initState() {
    super.initState();
    context.read<ReciepesCubit>().loadFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReciepesCubit, ReciepesState>(
      builder: (context, state) {
        final user = context.read<AuthCubit>().state.user;
        final watchList = state.watchList;
        final history = state.history;

        final poster = state.selectedPoster.isNotEmpty
            ? state.selectedPoster
            : ((user?.poster.isNotEmpty ?? false)
                ? user!.poster
                : AssetsManger.avatarOne);

        return Column(
          children: [

            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: ClipOval(
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: poster.isNotEmpty
                            ? Image.asset(poster, fit: BoxFit.cover)
                            : Container(
                                color: const Color(0xFF3A8DDE),
                                child: Icon(Icons.person,
                                    size: 50.r, color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StatItem(
                            count: watchList.length.toString(),
                            label: 'Cook List',
                          ),
                          StatItem(
                            count: history.length.toString(),
                            label: 'History',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 10.h, 20.w, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  capitalize(user!.name) ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),

            SizedBox(height: 18.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushNamed(
                              context, RoutesManger.updateProfile);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManger.yellow,
                          foregroundColor: ColorsManger.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: () => _showLogoutDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManger.red,
                          foregroundColor: ColorsManger.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Exit',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400)),
                            Icon(Icons.logout, size: 18.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabBarItem(
                    icon: Icons.list,
                    label: 'Cook List',
                    isSelected: widget.selectedTab == 0,
                    onTap: () => widget.onTabChanged(0),
                  ),
                  SizedBox(width: 32.w),
                  TabBarItem(
                    icon: Icons.folder,
                    label: 'History',
                    isSelected: widget.selectedTab == 1,
                    onTap: () => widget.onTabChanged(1),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8.h),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorsManger.darkGray,
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to logout?',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              context.read<ReciepesCubit>().clearAll();
              await context.read<AuthCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesManger.login, (r) => false);
            },
            child: Text('Yes', style: TextStyle(color: ColorsManger.red)),
          ),
        ],
      ),
    );
  }
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
