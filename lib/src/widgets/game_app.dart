import 'package:escape_space/src/components/abstract_screen.dart';
import 'package:escape_space/src/escape_space.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import 'overlay_screen.dart';
import 'score_card.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final EscapeSpace game;

  @override
  void initState() {
    super.initState();
    game = EscapeSpace();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color.fromARGB(255, 255, 255, 255),
          displayColor: const Color.fromARGB(255, 227, 255, 67),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 79, 3, 109),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    Expanded(
                      child: FittedBox(
                        child: Builder(
                          builder: (BuildContext innerContext) => GestureDetector(
                            onTap: () {
                              Navigator.of(innerContext).push(
                                MaterialPageRoute(
                                  builder: (context) => const AbstractScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: gameWidth,
                              height: gameHeight,
                              child: const OverlayScreen(
                                title: 'TAP TO PLAY',
                                subtitle: 'Use arrow keys or swipe',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
