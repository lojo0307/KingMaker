
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

  final MyGame game;
  Map<String, String> monsterInfo;
  Monster(this.game, this.monsterInfo);
  late SpriteSheet spriteSheet;
  late TextPainter textPainter;
  late MonsterPosition monsterPosition;
  late TextComponent textComponent;
  final List<String> categorytList =["slime", "skeleton", "goblin", "nutty", "panda", "bear"];
  final List<double> sizeX =[160, 216, 216, 99, 144, 268];
  final List<double> sizeY =[160, 144, 144, 99, 144, 93];
  late Vector2 spriteSize;
  @override
  Future<void> onLoad() async {
    int categoryId = int.tryParse(monsterInfo['category'] ?? '') ?? 0;
    final spriteImage = await Flame.images.load('${categorytList[categoryId-1]}_right.png');
    spriteSize = Vector2(sizeX[categoryId-1], sizeY[categoryId-1]);
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: spriteSize,
    );

    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1,loop: true);
    this.animation = animation;
    this.size = spriteSize;
    monsterPosition = parent as MonsterPosition;
    Color textColor;
    if (monsterInfo['important'] == '1') {
      textColor = Colors.red; // for important monsters
    } else {
      textColor = Colors.white; // for non-important monsters
    }
    textComponent=TextComponent(
        text: "${monsterInfo['title']}",
        textRenderer: TextPaint(
          style:TextStyle(
            fontFamily: 'PretendardBold',
            color: textColor,
            fontSize: 18,
            backgroundColor: Colors.black38,
          ),
        )
    );
    await textComponent.onLoad();
    final textWidth = textComponent.width;
    textComponent.position.setValues((size.x / 2.3) - (textWidth / 2.0),
        size.y-20);
    position=Vector2(77, 0);
    // textComponent.position.setValues(77,
    //     108);
    add(textComponent);
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
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
