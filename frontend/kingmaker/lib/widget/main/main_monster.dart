
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_game.dart';

class Monster extends SpriteAnimationComponent with TapCallbacks {
  static Vector2 spriteSize = Vector2(16, 16);
  final MyGame game;
  Map<String, String> monsterInfo;
  Monster(this.game, this.monsterInfo);
  late SpriteSheet spriteSheet;
  late TextPainter textPainter;

  @override
  Future<void> onLoad() async {
    final spriteImage = await Flame.images.load('ember.png');
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: spriteSize,
    );
    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    this.animation = animation;
    this.size = spriteSize;
    // position 초기화는 MonsterPosition에서 처리됩니다.
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 여기서는 position 업데이트나 경계 체크를 하지 않습니다.
    // 이것은 MonsterPosition에서 처리됩니다.
  }
}
