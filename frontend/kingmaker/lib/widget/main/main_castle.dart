import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/widget/main/main_game.dart';
import 'package:provider/provider.dart';

class Castle extends SpriteComponent {
  final MyGame game;
  final Map<String, String> level;
  final BuildContext context;
  late SpriteComponent spriteComponent;
  late TextComponent textComponent;

  Castle(this.context, this.game, this.level);
  @override
  Future<void> onLoad() async {
    super.onLoad(); // 상위 클래스의 onLoad 호출
    int? clevel = await Provider.of<KingdomProvider>(context, listen: false).kingdomDto?.level;
    String? castleName = await Provider.of<KingdomProvider>(context, listen: false).kingdomDto?.kingdomNm;
    print("성성성성 레벨  : $clevel");
    sprite = await Sprite.load('castle/Lv${clevel}.png');
    textComponent=TextComponent(
        text: "Lv.${clevel} ${castleName}",
        textRenderer: TextPaint(
            style:TextStyle(
              fontFamily: 'PretendardBold',
              fontSize: 25,
              backgroundColor: Colors.black38,
            ),
        )
    );
    await textComponent.onLoad();
    final textWidth = textComponent.width;
    if(clevel==1||clevel==2){
      //텐트일 때
      size = Vector2.all(250.0);
      position = Vector2(350, 100);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-5);
      add(textComponent);
    }else if(clevel==3||clevel==4||clevel==5){
      size = Vector2.all(240.0);
      position = Vector2(350, 100);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-15);
      add(textComponent);
    }else if(clevel==6){
      size = Vector2.all(250.0);
      position = Vector2(350, 110);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-5);
      add(textComponent);
    }else if(clevel==7){
      size = Vector2.all(270.0);
      position = Vector2(350, 140);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-35);
      add(textComponent);
    }else if(clevel==8||clevel==9){
      print('여기');
      size = Vector2.all(230.0);
      position = Vector2(350, 150);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-10);
      add(textComponent);
    }

  }


}
