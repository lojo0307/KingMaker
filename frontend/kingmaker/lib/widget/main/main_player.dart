// main_player.dart

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
class MainPlayer extends SpriteAnimationComponent {
  SpriteAnimation? animation;
  final Vector2 initialPosition;

  MainPlayer({required this.initialPosition});

  @override
  Future<void> onLoad() async {
    final playerSprite = await Flame.images.load('player_sprite.png'); // 스프라이트 시트 경로를 지정해주세요.

    final characterSpriteSheet = SpriteSheet(
      image : playerSprite,
      srcSize: Vector2(128, 128),  // 각 스프라이트의 크기를 지정해주세요.
    );

    animation = characterSpriteSheet.createAnimation(
      from: 0,
      to: 3,
      stepTime: 0.1, // 각 프레임이 얼마나 지속될지 지정해주세요.
      row: 0,
    );

    this..animation = animation
      ..position = initialPosition
      ..size = Vector2(128, 128);

  }

  @override
  void update(double dt) {
    super.update(dt);
    // 여기에 추가적인 업데이트 로직을 넣을 수 있습니다.
  }

// 필요한 경우 다른 메서드나 속성도 추가할 수 있습니다.
}
