import 'dart:async';

import 'package:escape_space/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:escape_space/src/components/components.dart';

class EscapeSpace extends FlameGame {
  EscapeSpace()
      : super(
            camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ));

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());
  }
}
