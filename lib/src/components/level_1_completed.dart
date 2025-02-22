import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

class Level1Completed extends StatefulWidget {
  const Level1Completed({super.key});

  @override
  State<Level1Completed> createState() => _Level1CompletedState();
}

class _Level1CompletedState extends State<Level1Completed>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _fadeController;
  bool _videoInitialized = false;
  bool _showCompletionMessage = false;

  @override
  void initState() {
    super.initState();

    // Fade animation controller for smooth transition
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30), // Smooth transition duration
    );

    _initializeVideo();
  }

  void _initializeVideo() {
    _videoController =
        VideoPlayerController.asset('assets/video/level_1_completed.mp4')
          ..initialize().then((_) {
            setState(() {
              _videoInitialized = true;
            });

            // Start the fade-in effect for smooth transition
            _fadeController.forward();
            Future.delayed(const Duration(milliseconds: 200), () {
              _videoController.play();
            });
            _videoController.setLooping(false);
          });

    _videoController.addListener(() {
      if (_videoController.value.position >=
          _videoController.value.duration) {
        setState(() {
          _showCompletionMessage = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Smooth fade-in for video player
          if (!_showCompletionMessage && _videoInitialized)
            FadeTransition(
              opacity: _fadeController,
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ),
            ),
          // Placeholder to hide transition delays
          if (!_videoInitialized)
            Container(
              color: Colors.black,
              alignment: Alignment.center,
              // child: const CircularProgressIndicator(color: Colors.white),
            ),
          // Level completed message and animated stars
          if (_showCompletionMessage)
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Color.fromARGB(255, 79, 3, 109),
                    Color.fromARGB(255, 77, 0, 107),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 40,
                        )
                            .animate()
                            .scale(
                              duration: (500 * (index + 1)).ms,
                              begin: Offset.zero,
                              end: const Offset(1.2, 1.2),
                            )
                            .then()
                            .scale(
                              duration: 250.ms,
                              begin: const Offset(1.2, 1.2),
                              end: Offset.zero,
                            ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Level 1 Completed",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                  ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
                  const SizedBox(height: 16),
                  Text(
                    'Continue Learning',
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}
