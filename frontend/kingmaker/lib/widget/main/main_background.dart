import 'package:flame/components.dart';

class GameBackground extends SpriteComponent  with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('background.png');
    position = Vector2(0, 0);
    size = gameRef.size;
    // size.setFrom(Vector2.all(1));
    // 화면 크기에 맞게 스케일을
    // 조정합니다.
  }

// onResize 메서드 제거
}
