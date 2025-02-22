import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:escape_space/src/components/level_1_completed.dart'; // Import the Level1Completed screen

class LevelOptions extends StatelessWidget {
  const LevelOptions({
    super.key,
    required this.question,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color.fromARGB(255, 79, 3, 109),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Question Text
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              question,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(duration: 1.0.seconds)
                .then()
                .fadeOut(duration: 1.0.seconds),
          ),
          const SizedBox(height: 20),
          // Options Row
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOptionButton(
                context,
                'assets/options/option_1.png',
              ),
              const SizedBox(height: 8),
              _buildOptionButton(context, 'assets/options/option_2.png'),
              const SizedBox(
                height: 8,
              ),
              _buildOptionButton(context, 'assets/options/option_3.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String assetPath) {
    return GestureDetector(
      onTap: () {
        print("Option selected: $assetPath"); // Debugging print statement
        if (assetPath == 'assets/options/option_2.png') {
          // Navigate to Level1Completed screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Level1Completed()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Wrong Reaction Selected")),
          );
        }
      },
      child: Container(
        width: 380,
        height: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
