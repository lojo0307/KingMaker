import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_game.dart';

class Castle extends SpriteComponent {
  final MyGame game;
  final Map<String, String> level;
  late SpriteComponent spriteComponent;
  Castle(this.game, this.level);
  late TextComponent textComponent;
  @override
  Future<void> onLoad() async {
    super.onLoad(); // 상위 클래스의 onLoad 호출
    sprite = await Sprite.load('castle/Lv${level['level']}.png');

    textComponent=TextComponent(
        text: "Lv.${level['level']} dsds겁쟁이 쉼터",
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
    if(level['level']=='1'||level['level']=='2'){
      //텐트일 때
      size = Vector2.all(250.0);
      position = Vector2(512, 100);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-55);
      add(textComponent);
    }else if(level['level']=='3'||level['level']=='4'||level['level']=='5'){
      size = Vector2.all(330.0);
      position = Vector2(512, 100);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-55);
      add(textComponent);
    }else if(level['level']=='6'||level['level']=='7'){
      size = Vector2.all(360.0);
      position = Vector2(512, 100);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-55);
      add(textComponent);
    }else if(level['level']=='8'||level['level']=='9'){
      size = Vector2.all(400.0);
      position = Vector2(512, 100);
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          size.y-55);
      add(textComponent);
    }

  }


}
