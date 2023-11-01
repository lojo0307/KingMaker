
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_game.dart';

import 'main_monster_position.dart';

class Monster extends SpriteAnimationComponent with TapCallbacks {
  static Vector2 spriteSize = Vector2(240,216);
  final MyGame game;
  Map<String, String> monsterInfo;
  Monster(this.game, this.monsterInfo);
  late SpriteSheet spriteSheet;
  late TextPainter textPainter;
  late MonsterPosition monsterPosition;
  late TextComponent textComponent;
  @override
  Future<void> onLoad() async {
    final spriteImage = await Flame.images.load('slime_right.png');
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: spriteSize,
    );

    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    this.animation = animation;
    this.size = spriteSize;
    monsterPosition = parent as MonsterPosition;
    textComponent=TextComponent(text: "${monsterInfo['todo_nm']}");
    await textComponent.onLoad();
    final textWidth = textComponent.width;
    textComponent.position.setValues((size.x / 2.3) - (textWidth / 2.1),
        size.y-55);
    add(textComponent);
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // if (monsterPosition.velocity.x > 0) {
    //   // 오른쪽으로 움직이는 경우
    //   changeAnimation('slime_right.png');
    // } else if (monsterPosition.velocity.x < 0) {
    //   // 왼쪽으로 움직이는 경우
    //   changeAnimation('slime_left.png');
    // }
    // 여기서는 position 업데이트나 경계 체크를 하지 않습니다.
    // 이것은 MonsterPosition에서 처리됩니다.
  }

  void changeAnimation(String imagePath) async {
    final spriteImage = await Flame.images.load(imagePath);
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: spriteSize,
    );
    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    this.animation = animation;
  }
}
