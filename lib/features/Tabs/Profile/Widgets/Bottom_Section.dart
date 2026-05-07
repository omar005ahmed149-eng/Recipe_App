import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:recipes/core/models/recipe_Model.dart';
import 'package:recipes/core/resources/assets_manger.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/recipe_details/recipe_details_screen.dart';

import '../../../../core/bloc/reciepes/reciepes_cubit.dart';
import '../../../../core/bloc/reciepes/reciepes_state.dart';

class BottomSection extends StatelessWidget {
  final int selectedTab;
  const BottomSection({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReciepesCubit, ReciepesState>(
      builder: (context, state) {
        final List<ReciepeModel> currentList = selectedTab == 0
            ? state.watchList
            : state.history;

        if (currentList.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AssetsManger.popcorn, width: 140.w),
                SizedBox(height: 12.h),
                Text(
                  selectedTab == 0
                      ? 'No bookmarked reciepes yet'
                      : 'No reciepes watched yet',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(16.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
          ),
          itemCount: currentList.length,
          itemBuilder: (_, i) {
            final recipe = currentList[i];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => recipeDetailsScreen(recipe: recipe),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(recipe.poster_image, fit: BoxFit.cover),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star,
                                color: ColorsManger.yellow, size: 10.r),
                            SizedBox(width: 2.w),
                            Text(
                              recipe.rating,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
