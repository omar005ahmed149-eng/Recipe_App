import 'package:flutter/material.dart';
import 'package:recipes/core/models/recipe_Model.dart';
import 'package:recipes/features/recipe_details/recipe_details_screen.dart';
import '../../features/Tabs/Home/Widgets/Rating_Badge.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.rating,
    required this.poster_image,
    this.recipe,
  });
  final String rating;
  final String poster_image;
  final ReciepeModel? recipe;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.recipe != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => recipeDetailsScreen(recipe: widget.recipe!),
            ),
          );
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedScale(
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 140,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.poster_image,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: RatingBadge(rating: widget.rating),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
