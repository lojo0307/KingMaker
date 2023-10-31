import 'dart:math';
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
  final Random _random = Random();
  late SpriteSheet spriteSheet;
  Vector2 velocity = Vector2.zero();
  int currentRow = 0;
  Map<String, String> monsterInfo;
  Monster(this.game, this.monsterInfo);
  late TextPainter textPainter; // TextPaint에서 TextPainter로 변경
  late Rect textRect;

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
    this.position = Vector2(
        // _random.nextDouble() * (1024 - spriteSize.x),
        // _random.nextDouble() * (1024 - spriteSize.y)
      100,
      100
    );
    setRandomVelocity();
    textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textSpan = TextSpan(text:  monsterInfo['todo_nm'], style: TextStyle(color: Colors.black, fontSize: 16.0));
    textPainter.text = textSpan;
    textPainter.layout();

    textRect = Rect.fromLTWH(
        position.x + size.x / 2 - textPainter.width / 2,
        position.y + size.y + 5,
        textPainter.width,
        textPainter.height
    );
  }

  void setRandomVelocity() {
    double speed = 30.0;
    double direction = _random.nextDouble() * 2 * pi;
    velocity = Vector2(cos(direction) * speed, sin(direction) * speed);
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  @override
  void update(double dt) {

    super.update(dt);
    position += velocity*dt;
    // print('Game world size: ');
    textRect = Rect.fromLTWH(
        position.x,
        position.y,
        textPainter.width,
        textPainter.height
    );

    if (position.x <= 0 || position.x >= 1024 - size.x) {
      velocity.x = -velocity.x;
    }
    if (position.y <= 0 || position.y >= 1024 - size.y) {
      velocity.y = -velocity.y;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(textRect, Paint()..color = Colors.red..style = PaintingStyle.stroke);

    // 텍스트를 textRect의 위치에 그립니다.
    textPainter.paint(canvas, textRect.topLeft);
  }
}
