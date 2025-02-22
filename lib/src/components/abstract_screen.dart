import 'package:escape_space/src/Levels/Level_1_Chemistry_Lab.dart';
import 'package:escape_space/src/widgets/game_app.dart';
import 'package:flutter/material.dart';

class AbstractScreen extends StatefulWidget {
  const AbstractScreen({super.key});

  @override
  State<AbstractScreen> createState() => _AbstractScreenState();
}

class _AbstractScreenState extends State<AbstractScreen>
    with SingleTickerProviderStateMixin {
  int currentScreen = 1; // Variable to track the screen number
  bool _isTransitioning = false;

  void _goToNextScreen() async {
    if (_isTransitioning) return; // Prevent overlapping animations
    setState(() => _isTransitioning = true);
    await _fadeOut(); // Play fade-out animation

    setState(() {
      if (currentScreen < 4) currentScreen++;
      else {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                Level1ChemistryLab(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
        return;
      }
    });
    _fadeIn(); // Play fade-in animation
  }

  void _goToPreviousScreen() async {
    if (_isTransitioning) return; // Prevent overlapping animations
    setState(() => _isTransitioning = true);
    await _fadeOut(); // Play fade-out animation

    setState(() {
      if (currentScreen > 1) currentScreen--;
    });
    _fadeIn(); // Play fade-in animation
  }

  final _opacityController = ValueNotifier<double>(1.0);

  Future<void> _fadeOut() async {
    for (double i = 1.0; i >= 0.0; i -= 0.05) {
      _opacityController.value = i;
      await Future.delayed(const Duration(milliseconds: 20));
    }
  }

  void _fadeIn() async {
    for (double i = 0.0; i <= 1.0; i += 0.05) {
      _opacityController.value = i;
      await Future.delayed(const Duration(milliseconds: 20));
    }
    setState(() => _isTransitioning = false);
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<double>(
        valueListenable: _opacityController,
        builder: (context, opacity, child) {
          return AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/$currentScreen.png"), // Dynamically set image
              fit: BoxFit.fitHeight, // Ensures the image fully covers the screen
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  const SizedBox(width: 100),
                  GestureDetector(
                    onTap: _goToPreviousScreen, // Navigate to the previous screen
                    child: Image.asset(
                      "assets/buttons/previous.png", // Path for the previous button
                      width: 170, // Define a fixed width
                      height: 50, // Define a fixed height
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _goToNextScreen, // Navigate to the next screen
                    child: Image.asset(
                      "assets/buttons/next.png", // Path for the next button
                      width: 170, // Define a fixed width
                      height: 50, // Define a fixed height
                    ),
                  ),
                  const SizedBox(width: 100),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
