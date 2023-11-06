
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_camera_focus.dart';
import 'package:flame/extensions.dart';
import 'package:kingmaker/widget/main/main_castle.dart';
import 'package:kingmaker/widget/main/main_monster_position.dart';

import '../../page/todo_detail_page.dart';
import 'main_background.dart';
import 'main_player.dart';

class MyGame extends FlameGame with MultiTouchDragDetector, TapDetector  {
  late Vector2 backgroundSize;
  late FocusArea focusArea;
  late MainPlayer player;
  late List<MonsterPosition> monsterList;
  final BuildContext context;


  MyGame(this.context) {
    camera.viewport.size = Vector2(1024, 1024);
    player = MainPlayer(this);
    world = MyWorld(this, player);
    backgroundSize = Vector2(1024, 1024);
    focusArea = FocusArea();
    focusArea.position = backgroundSize / 2;
    camera.follow(focusArea);
    //몬스터 리스트 초기화 -지금은 임의 값
    monsterList = [MonsterPosition(this,{'todo_nm' : "첫번째 몬스터",'category_id' :'1'}),
    MonsterPosition(this,{'todo_nm' : "2번째 몬스터",'category_id' :'2'}),
      MonsterPosition(this,{'todo_nm' : "3번째 몬스터",'category_id' :'4'}),
      MonsterPosition(this,{'todo_nm' : "2번째 몬스터",'category_id' :'1'}),
      MonsterPosition(this,{'todo_nm' : "3번째 몬스터",'category_id' :'3'}),
    MonsterPosition(this,{'todo_nm' : "4번째 몬스터", 'category_id' :'4'}),
      MonsterPosition(this,{'todo_nm' : "5번째 몬스터",'category_id' :'5'}),
      MonsterPosition(this,{'todo_nm' : "6번째 몬스터", 'category_id' :'6'}),
      MonsterPosition(this,{'todo_nm' : "7번째 몬스터", 'category_id' :'6'})
    ];
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
      player.TapUp();
      return;
    }//몬스터를 클릭했을 때의 로직

    for (MonsterPosition monster in monsterList) {
      if (monster.toRect().contains(worldPosition.toOffset())) {
        print('${monster.monsterInfo} was tapped!');
        // 필요한 로직 (예: 몬스터를 잡거나, 정보를 표시하거나 등) 추가하기
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TodoDetailPage())
        // );


        break;  // 만약 한 번에 하나의 몬스터만 탭할 수 있다면, 루프를 종료
      }
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

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    // 다른 컴포넌트 로드...

    // 경험치 바 로드 및 설정

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
    print('Initial game world size: $game.size');
    backgroundSize = Vector2(1024, 1024);
    final bgSprite = await Sprite.load('background.png');
    background = GameBackground(bgSprite, backgroundSize);
    add(background);






    //성
    add(Castle(game, {'level': '9'}));
    FocusArea focusArea = FocusArea();
    add(focusArea);
    game.setFocusArea(focusArea);  // MyGame의 focusArea 설정


    // game.player = player;
    // game.add(game.player);
    add(player);
    for(int i=0; i<this.game.monsterList.length; i++){
      add(this.game.monsterList[i]);
    }


  }

}