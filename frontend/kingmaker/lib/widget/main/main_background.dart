import 'package:flame/components.dart';
import 'package:flame/events.dart';

class GameBackground extends SpriteComponent  with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('background.png');
    position = Vector2.zero(); // Start position
    size = gameRef.size * 2;
  }

  void handleDragUpdate(DragUpdateInfo info) {

    final delta = Vector2(info.delta.global.x, info.delta.global.y);


    position = position + delta;

    position.x = position.x.clamp(
      gameRef.size.x - size.x,
      0, // Right-most boundary
    );
    position.y = position.y.clamp(
      gameRef.size.y - size.y,
      0,
    );
  }


}
