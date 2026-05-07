import 'package:flutter/material.dart';

import '../../../../core/widgets/Category_card.dart';
import '../../../../core/models/recipe_Model.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key, required this.label, required this.recipes});

  final String label;
  final List<ReciepeModel> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
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
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: recipes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return CategoryCard(
                  rating: recipes[index].rating,
                  poster_image: recipes[index].poster_image,
                  recipe: recipes[index], // pass full recipe for navigation
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
