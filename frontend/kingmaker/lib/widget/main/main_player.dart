
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';

import 'package:kingmaker/widget/main/main_game.dart';

class MainPlayer extends SpriteAnimationComponent with TapCallbacks {
  static Vector2 spriteSize = Vector2(128, 128);
  final MyGame game;

  late SpriteSheet spriteSheet;
  int currentRow = 0; // 현재 애니메이션 행을 나타내는 변수

  MainPlayer(this.game);

  @override
  Future<void> onLoad() async {
    final spriteImage = await Flame.images.load('player_sprite.png');
    spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: spriteSize,
    );

    setAnimationRow(currentRow);
    this.size = spriteSize;
    this.position = Vector2(448, 448);
  }

  @override
  void onTapUp(TapUpEvent event) {
    Vector2 worldPosition = game.camera.localToGlobal(event.localPosition);
    if (toRect().contains(worldPosition.toOffset())) {
      print('player onTapUp called');

      toggleAnimationRow();
    }
  }

  void toggleAnimationRow() {
    if (currentRow == 0) {
      currentRow = 1;
    } else {
      currentRow = 0;
    }

    setAnimationRow(currentRow);
  }

  void setAnimationRow(int row) {
    final animation = spriteSheet.createAnimation(row: row, stepTime: 0.1);
    this.animation = animation;
  }

  Rect toRect() {
    return Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void playSecondRowAnimation() {
    toggleAnimationRow();
    final tappedAnimation = spriteSheet.createAnimation(row: currentRow, stepTime: 0.1);
    this.animation = tappedAnimation;
  }
}
