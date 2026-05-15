import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  final String prevUrl;
  final String currentUrl;
  final Animation<double> animation;

  const BlurredBackground({
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
    return Image.asset(
      url,
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(0.78),
      colorBlendMode: BlendMode.darken,
      errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF0a0a0f)),
    );
  }
}
