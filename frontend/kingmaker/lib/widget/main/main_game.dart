import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'main_background.dart';
class mainGame extends FlameGame with MultiTouchDragDetector  {
  late GameBackground _background;

  @override
  Future< void > onLoad() async {
    _background = GameBackground();
    add(_background);
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
    _background.handleDragUpdate(info);
  }
}
