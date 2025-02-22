import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/widgets/game_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  runApp(const GameApp());
}
