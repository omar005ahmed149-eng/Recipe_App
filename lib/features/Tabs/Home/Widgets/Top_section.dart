import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/recipe_details/recipe_details_screen.dart';

import '../../../../core/resources/assets_manger.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/models/recipe_Model.dart';
import '../../../../core/models/recipes_Data.dart';
import 'Rating_Badge.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key, required this.activeIndex});

  final int activeIndex;

  static final PageController _pageController = PageController(
    viewportFraction: 0.62,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 56.h),

        Image.asset(AssetsManger.available),

        SizedBox(height: 16.h),

        SizedBox(
          height: 360.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: ReciepeData.featuredReciepes.length,
            onPageChanged: (index) {
              context.read<HomeBloc>().add(HomePageChanged(index));
            },
            itemBuilder: (context, index) {
              return HeroCard(
                recipe: ReciepeData.featuredReciepes[index],
                isActive: index == activeIndex,
              );
            },
          ),
        ),
      ],
    );
  }
}

class HeroCard extends StatelessWidget {
  final ReciepeModel recipe;
  final bool isActive;

  const HeroCard({super.key, required this.recipe, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => recipeDetailsScreen(recipe: recipe),
        ),
      ),
      child: AnimatedScale(
        scale: isActive ? 1.0 : 0.88,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: ColorsManger.white,
                  child: Image.asset(
                    recipe.poster_image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: RatingBadge(rating: recipe.rating),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
