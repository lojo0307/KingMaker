import 'package:flame/components.dart';

class GameBackground extends SpriteComponent with HasGameRef {
  GameBackground(Sprite sprite, Vector2 size)
      : super(sprite: sprite, size: size);
}
