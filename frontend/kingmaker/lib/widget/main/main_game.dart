

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:kingmaker/widget/main/main_camera_focus.dart';


import 'main_background.dart';
import 'main_player.dart';

class MyGame extends FlameGame with MultiTouchDragDetector {
  late Vector2 backgroundSize;
  late FocusArea focusArea;
  MyGame() {
    world = MyWorld(this);
    backgroundSize = Vector2(1024, 1024);
    focusArea = FocusArea();
    focusArea.position = backgroundSize / 2;
    camera.follow(focusArea);
  }
  void setFocusArea(FocusArea fa) {  // focusArea를 설정하는 메서드
    focusArea = fa;
  }


  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {

    final delta = info.delta.global;
    // 드래그 방향 반전
    final adjustedDelta = Vector2(-delta.x, -delta.y);
    final newPosition = focusArea.position + adjustedDelta;

    // 카메라 위치 제한 (배경을 벗어나지 않게 함)
    // 화면의 절반 크기를 고려
    double halfScreenWidth = size.x / 2;
    double halfScreenHeight = size.y / 2;

    newPosition.x = newPosition.x.clamp(halfScreenWidth, backgroundSize.x - halfScreenWidth);
    newPosition.y = newPosition.y.clamp(halfScreenHeight, backgroundSize.y - halfScreenHeight);

    focusArea.position.setFrom(newPosition);


    camera.follow(focusArea);

  }
}

class MyWorld extends World {
  late GameBackground background;
  late Vector2 backgroundSize;
  final MyGame game;
  MyWorld(this.game);
  @override
  Future<void> onLoad() async {
    backgroundSize = Vector2(1024, 1024);
    final bgSprite = await Sprite.load('background.png');
    background = GameBackground(bgSprite, backgroundSize);
    add(background);

    FocusArea focusArea = FocusArea();
    add(focusArea);
    game.setFocusArea(focusArea);  // MyGame의 focusArea 설정

    final player = MainPlayer(initialPosition: Vector2(512, 512));
    add(player);
  }
}