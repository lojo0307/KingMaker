import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_game.dart';


class Duck extends SpriteAnimationComponent with TapCallbacks {

  final MyGame game;
  final double x;
  final double y;
  final bool dir;
  Duck(this.game, this.x, this.y, this.dir);
  late SpriteSheet spriteSheet;


  @override
  Future<void> onLoad() async {
    final spriteImage = await Flame.images.load('duck.png');
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2(15, 15),

    );
    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1,loop: true);
    this.animation = animation;

    position=Vector2(x, y);

    if(dir){
      flipHorizontally();
    }
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
