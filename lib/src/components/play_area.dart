import 'dart:async';

import 'package:flame/collisions.dart';                         // Add this import
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../escape_space.dart';

class PlayArea extends RectangleComponent with HasGameReference<EscapeSpace> {
  PlayArea()
      : super(
          paint: Paint()..color = const Color.fromARGB(255, 0, 0, 0),
          children: [RectangleHitbox()],                        // Add this parameter
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}