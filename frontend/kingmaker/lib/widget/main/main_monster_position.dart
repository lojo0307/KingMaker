
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_game.dart';
import 'package:kingmaker/widget/main/main_monster.dart';
enum MonsterDirection {
  LEFT,
  RIGHT,
}
class MonsterPosition extends PositionComponent {
  final MyGame game;
  final Random _random = Random();
  final List<String> categorytList =["slime", "skeleton", "goblin", "reaper", "slime", "slime"];
  late int categoryId;
  MonsterDirection currentDirection = MonsterDirection.RIGHT;
  Vector2 velocity = Vector2.zero();
  Map<String, String> monsterInfo;
  MonsterPosition(this.game, this.monsterInfo) {
    setRandomVelocity();
    this.size = Vector2(240,216);
  }
  late Monster monster;
  late MonsterText monsterText;

  @override
  void onLoad() {
    super.onLoad();
    position = Vector2(
        _random.nextDouble() * (1024 - size.x),
        _random.nextDouble() * (1024 - size.y)
    );
    categoryId = int.tryParse(monsterInfo['category_id'] ?? '') ?? 0;
    monster = Monster(this.game, monsterInfo);
    monsterText = MonsterText(monsterInfo);

    add(monster);
    // add(monsterText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;  // MonsterPosition의 위치를 업데이트
    if (velocity.x > 0 && currentDirection != MonsterDirection.RIGHT) {
      currentDirection = MonsterDirection.RIGHT;
      monster.changeAnimation('${categorytList[categoryId-1]}_right.png');
    } else if (velocity.x < 0 && currentDirection != MonsterDirection.LEFT) {
      currentDirection = MonsterDirection.LEFT;
      monster.changeAnimation('${categorytList[categoryId-1]}_left.png');
    }
    if (monster != null && monsterText != null) {
      // monster.position = position;
      monsterText.position = Vector2(-14, 10);// 원하는 오프셋으로 변경하세요.
    }

    if (position.x <= 0 || position.x >= 1024 - monster.size.x) {
      velocity.x = -velocity.x;
    }
    if (position.y <= 0 || position.y >= 1024 - monster.size.y) {
      velocity.y = -velocity.y;
    }
  }
  void setRandomVelocity() {
    double speed = 30.0;
    double direction = _random.nextDouble() * 2 * pi;
    velocity = Vector2(cos(direction) * speed, sin(direction) * speed);
  }
}

class MonsterText extends TextComponent{
  final Map<String, String> monsterInfo;
  late TextPainter textPainter;

  MonsterText(this.monsterInfo) {
    textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textSpan = TextSpan(
      text: monsterInfo['todo_nm'],
      style: TextStyle(color: Colors.black, fontSize: 16.0),
    );
    textPainter.text = textSpan;
    textPainter.layout();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textPainter.paint(canvas, position.toOffset());
  }
}