import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlurredBackground extends StatelessWidget {
  final String prevUrl;
  final String currentUrl;
  final Animation<double> animation;

  const BlurredBackground({
    super.key,
    required this.prevUrl,
    required this.currentUrl,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBgImage(prevUrl),
        FadeTransition(
          opacity: animation,
          child: _buildBgImage(currentUrl),
        ),
      ],
    );
  }

  Widget _buildBgImage(String url) {
    if (url.isEmpty) {
      return const ColoredBox(color: Color(0xFF0a0a0f));
    }

      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        color: Colors.black.withOpacity(0.78),
        colorBlendMode: BlendMode.darken,
        placeholder: (_, __) => const ColoredBox(color: Color(0xFF0a0a0f)),
        errorWidget: (_, __, ___) => const ColoredBox(color: Color(0xFF0a0a0f)),
      );
  }
}