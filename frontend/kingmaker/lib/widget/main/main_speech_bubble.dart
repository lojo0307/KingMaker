import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_player.dart';

class MainSpeechBubble extends PositionComponent with HasGameRef {
  late SpriteComponent bubbleSprite;
  late TextComponent textComponent;
  MainPlayer? mainPlayer;
  List<String> list = ['곤방와','대단해~!','우효-',' 왕으로 \n 만들어줘'];
  final text;
  MainSpeechBubble(Vector2 position, String this.text)
      : super(position: position, size: Vector2(130, 122));
  Random random = Random();
  @override
  Future<void> onLoad() async {
    final spriteImage = await Sprite.load('speech_bubble.png');
    bubbleSprite = SpriteComponent(sprite: spriteImage, size: size);
    add(bubbleSprite);

    textComponent = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'PretendardBold',
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    )
      ..anchor = Anchor.center
      ..position = Vector2(size.x / 2, size.y / 2.5);
    add(textComponent);
    if (parent is MainPlayer) {
      mainPlayer = parent as MainPlayer;
    }
    // 초기 상태에서 말풍선을 숨깁니다.
    removeFromParent();
  }

  void showBubble(String text) {
    if (mainPlayer == null) {
      // mainPlayer가 초기화되지 않았다면, 에러를 로그하고 리턴합니다.
      print('Error: MainPlayer is not initialized for MainSpeechBubble.');
      return;
    }

    textComponent.text = list[random.nextInt(list.length)];
    addToParent(mainPlayer!); // Non-null assertion을 사용합니다.

    // 일정 시간 후에 말풍선을 숨깁니다.
    Future.delayed(Duration(seconds: 5)).then((_) {
      removeFromParent();
    });
  }
}
