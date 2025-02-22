import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LevelIntro extends StatelessWidget {
  const LevelIntro({
    super.key,
    required this.level,
    required this.task,
  });

  final String level;
  final String task;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.5),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color.fromARGB(255, 79, 3, 109),
            Color.fromARGB(0, 79, 3, 109),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            level,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 30,
                ),
          ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
          const SizedBox(height: 16),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 16), // Add some padding
            child: Text(
              task,
              textAlign: TextAlign.justify, // Justify the text
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 15,
                  ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(duration: 1.0.seconds)
                .then()
                .fadeOut(duration: 1.0.seconds),
          ),
        ],
      ),
    );
  }
}
