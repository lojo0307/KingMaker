import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

import 'main_background.dart';
class mainGame extends FlameGame {

  @override
  Future< void > onLoad() async {
    final background = await GameBackground();
    add(background);
  }
}
