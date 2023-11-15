
import 'package:flame/text.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';

import 'package:kingmaker/widget/main/main_game.dart';
import 'package:provider/provider.dart';

import 'main_speech_bubble.dart';

class MainPlayer extends SpriteComponent with TapCallbacks {
  static Vector2 spriteSize = Vector2(128, 128);
  final MyGame game;

  late SpriteComponent spriteComponent;
  late TextComponent textComponent;
  late MainSpeechBubble? speechBubble;
  final BuildContext context;
  MainPlayer(this.context, this.game);

  @override
  Future<void> onLoad() async {
      String? name = await Provider.of<MemberProvider>(context, listen: false).member?.nickname;
      String? gender = await Provider.of<MemberProvider>(context, listen: false).member?.gender;
      String img = gender == "MAN" ? "male": "female";
      sprite = await Sprite.load('${img}.png');
      size = Vector2(65,110);
      position = Vector2(272, 300);
      textComponent=TextComponent(
          text: name,
          textRenderer: TextPaint(
            style:TextStyle(
              fontFamily: 'PretendardBold',
              fontSize: 20,
              backgroundColor: Colors.black38,

            ),
          )
      );
      await textComponent.onLoad();
      final textWidth = textComponent.width;
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          120);
      add(textComponent);


      //말풍선 컴포넌트 생성
      speechBubble = MainSpeechBubble(Vector2(-33, -130), "엄준식");
      await speechBubble!.onLoad();
      add(speechBubble!);

      propagateToChildren((p0) => true);
  }

  void TapUp(){
    speechBubble?.showBubble("Hellow");
  }


  @override
  void onTapUp(TapUpEvent event) {
    // Vector2 worldPosition = game.camera.localToGlobal(event.localPosition);
    // if (toRect().contains(worldPosition.toOffset())) {
    //   print('player onTapUp called');
    //   // toggleAnimationRow();
    // }
    super.onTapUp(event);
    // speechBubble.showBubble("Hellow");
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}
