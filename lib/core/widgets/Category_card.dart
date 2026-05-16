import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipes/core/models/recipe_Model.dart';
import 'package:recipes/features/recipe_details/recipe_details_screen.dart';
import '../../features/Tabs/Home/Widgets/Rating_Badge.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.mealName,
    required this.poster_image,
    this.recipe,
  });
  final String mealName;
  final String poster_image;
  final ReciepeModel? recipe;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _hovered = false;

  Widget _posterImage() {
    final source = widget.poster_image;

    if (source.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: source,
        fit: BoxFit.cover,
        placeholder: (_, __) => const ColoredBox(
          color: Colors.black26,
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        errorWidget: (_, __, ___) => const ColoredBox(color: Colors.black26),
      );
    }

    return Image.asset(
      source,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black26),
    );
  }

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
                  _posterImage(),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: RatingBadge(rating: widget.mealName),
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