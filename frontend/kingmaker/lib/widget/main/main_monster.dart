import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:kingmaker/widget/main/main_game.dart';

class Monster extends SpriteAnimationComponent with TapCallbacks {
  static Vector2 spriteSize = Vector2(16, 16);
  final MyGame game;
  final Random _random = Random();
  late SpriteSheet spriteSheet;
  Vector2 velocity = Vector2.zero();
  int currentRow = 0;

  var monsterInfo; // 현재 애니메이션 행을 나타내는 변수

  Monster(this.game, this.monsterInfo);

  @override
  Future<void> onLoad() async {
    final spriteImage = await Flame.images.load('ember.png');
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: spriteSize,
    );
    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);

    // 애니메이션, 초기 위치, 크기 설정
    this.animation = animation;
    this.size = spriteSize;
    this.position = Vector2(
        _random.nextDouble() * (1024 - spriteSize.x), // x 좌표
        _random.nextDouble() * (1024 - spriteSize.y) // y 좌표
    );
    setRandomVelocity();
  }
    void setRandomVelocity() {
      double speed = 30.0;  // 원하는 속도로 설정
      double direction = _random.nextDouble() * 2 * pi;  // 0에서 2π 사이의 랜덤한 각도
      velocity = Vector2(cos(direction) * speed, sin(direction) * speed);
    }


    Rect toRect() {
      return Rect.fromLTWH(position.x, position.y, size.x, size.y);
    }

    @override
    void update(double dt) {
      super.update(dt);

      // 위치 업데이트
      position += velocity * dt;

      // 경계 체크
      if (position.x <= 0 || position.x >= 1024 - size.x) {
        velocity.x = -velocity.x;  // x 방향 반전
      }
      if (position.y <= 0 || position.y >= 1024 - size.y) {
        velocity.y = -velocity.y;  // y 방향 반전
      }
    }

}