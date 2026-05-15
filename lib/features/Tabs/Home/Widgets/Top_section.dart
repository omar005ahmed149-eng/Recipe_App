import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/APIservice/Get_Resources.dart';
import 'package:recipes/core/resources/colors_manger.dart';
import 'package:recipes/features/recipe_details/recipe_details_screen.dart';

import '../../../../APIservice/Categories.dart';
import '../../../../APIservice/Meals.dart';
import '../../../../core/resources/assets_manger.dart';
import '../../../../core/widgets/Category_card.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/models/recipe_Model.dart';
import '../../../../core/models/recipes_Data.dart';
import 'Rating_Badge.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key, required this.activeIndex});

  final int activeIndex;

  static final PageController _pageController = PageController(
    viewportFraction: 0.62,
  );

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 56.h),

        Image.asset(AssetsManger.available),

        SizedBox(height: 16.h),

        SizedBox(
          height: 360.h,
          child: FutureBuilder(
            future: GetResponse.getCategories(),
            builder: (BuildContext context,  snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              }
              List<Categories> categories = snapshot.data ?? [];

              return PageView.builder(
                controller: TopSection._pageController,
                itemCount: categories.length,
                onPageChanged: (index) {
                  context.read<HomeBloc>().add(HomePageChanged(index));
                },
                itemBuilder: (context, index) {
                  return CategoryCard(
                    mealName: categories[index].strCategory??"",
                    poster_image:categories[index].strCategoryThumb?? "",
                  );
                },
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
