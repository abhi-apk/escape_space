import 'package:escape_space/src/components/level_intro.dart';
import 'package:escape_space/src/components/level_options.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:escape_space/src/components/level_intro.dart'; // Assuming LevelOptions is in a separate file
import 'package:escape_space/src/components/level_options.dart'; // Assuming LevelIntro is in a separate file

class Level1ChemistryLab extends StatefulWidget {
  const Level1ChemistryLab({super.key});

  @override
  State<Level1ChemistryLab> createState() => _Level1ChemistryLabState();
}

class _Level1ChemistryLabState extends State<Level1ChemistryLab> {
  bool _showIntro = false;
  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    // Show LevelIntro widget after 1 second
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _showIntro = true;
      });
    });
  }

  void _handlePlayButtonPressed() {
    setState(() {
      _showIntro = false; // Hide the LevelIntro widget
    });
    // Show LevelOptions widget after 3 seconds
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _showOptions = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color.fromARGB(255, 79, 3, 109),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/level_1.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Stack(
          children: [
            // Show LevelIntro if _showIntro is true
            if (_showIntro)
              LevelIntro(
                level: "Level 1",
                task:
                    "Choose the reaction that can freeze the aliens. \nSo that you can escape",
              ),
            // Show Play button if _showIntro is true and options are not yet displayed
            if (_showIntro && !_showOptions)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: ElevatedButton(
                    onPressed: _handlePlayButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Play",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            // Show LevelOptions if _showOptions is true
            if (_showOptions)
              LevelOptions(
                question: "Choose the reaction to freeze the aliens:",
              ),
          ],
        ),
      ),
    );
  }
}
