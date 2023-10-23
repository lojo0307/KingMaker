import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:kingmaker/widget/main/main_camera_focus.dart';
import 'package:kingmaker/widget/main/main_monster.dart';


import 'main_background.dart';
import 'main_player.dart';

class MyGame extends FlameGame with MultiTouchDragDetector, TapDetector  {
  late Vector2 backgroundSize;
  late FocusArea focusArea;
  late MainPlayer player;

  MyGame() {
    player = MainPlayer(this);
    world = MyWorld(this, player);
    backgroundSize = Vector2(1024, 1024);
    focusArea = FocusArea();
    focusArea.position = backgroundSize / 2;
    camera.follow(focusArea);
  }
  void setFocusArea(FocusArea fa) {  // focusArea를 설정하는 메서드
    focusArea = fa;
  }
  @override
  void onTapUp(TapUpInfo info) {
    print(info.eventPosition.global);

    Vector2 worldPosition = camera.globalToLocal(info.eventPosition.global);
    print(worldPosition);
    if (player.toRect().contains(worldPosition.toOffset())) {
      print('Character was tapped!');
      player.playSecondRowAnimation();
    }
  }

  bool isWithinGameBounds(Vector2 position){
    return position.x >= 0 &&
        position.y >= 0 &&
        position.x <= size.x &&
        position.y <= size.y;
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

  final MainPlayer player;

  MyWorld(this.game, this.player);

  @override
  Future<void> onLoad() async {
    backgroundSize = Vector2(1024, 1024);
    final bgSprite = await Sprite.load('background.png');
    background = GameBackground(bgSprite, backgroundSize);
    add(background);

    FocusArea focusArea = FocusArea();
    add(focusArea);
    game.setFocusArea(focusArea);  // MyGame의 focusArea 설정


    // game.player = player;
    // game.add(game.player);
    add(player);
    for(int i=0; i<50; i++){
      Monster monster =Monster(game);
      add(monster);
    }

  }

}