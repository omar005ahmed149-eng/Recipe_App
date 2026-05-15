import 'package:flutter/material.dart';
import 'package:recipes/APIservice/Categories.dart';
import 'package:recipes/APIservice/Meals.dart';

import '../../../../APIservice/Get_Resources.dart';
import '../../../../core/widgets/Category_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({super.key});



  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  late Future<List<Categories>?> _categoriesFuture;
  late Future<List<Meals>?> _MealsFuture;
  late String categoryName;

  @override
  void initState() {
    super.initState();
    categoryName = '';
    _categoriesFuture = GetResponse.getCategories();
    _MealsFuture = GetResponse.getMeals(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: FutureBuilder<List<Categories>?>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          List<Categories> categories = snapshot.data ?? [];

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 12),
            itemBuilder: (BuildContext context, int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categories[index].strCategory ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'See More →',
                        style: TextStyle(
                          color: Color(0xFFF5C518),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Meals>?>(
                    future: GetResponse.getMeals(categories[index].strCategory ?? ''),
                    builder: (context, mealSnapshot) {
                      if (mealSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      if (mealSnapshot.hasError) {
                        return const Center(child: Text("Error"));
                      }

                      List<Meals> meals = mealSnapshot.data ?? [];

                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: meals.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            mealName: meals[index].strMeal ?? "",
                            poster_image:meals[index].strMealThumb?? "",
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}