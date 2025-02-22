import 'package:escape_space/src/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:escape_space/src/components/components.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.15),
      // decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: gameWidth), vertical: BorderSide(width: gameHeight),), ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 50,
            ),
          ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 30,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 1.seconds)
              .then()
              .fadeOut(duration: 1.seconds),
        ],
      ),
    );
  }
}