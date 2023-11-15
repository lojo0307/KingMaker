import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_player.dart';

class MainSpeechBubble extends PositionComponent with HasGameRef {
  late SpriteComponent bubbleSprite;
  late TextComponent textComponent;
  MainPlayer? mainPlayer;
  List<String> list = ['이리 오너라', '여기는 어디?', '으악!\n고블린이다!',
    '내가 왕...?', '허성백\n최고', '백성들은\n들으라', '스프가 짜다', '동맹할 사람?',
  '반란은\n용서모태!', '노 세금\n노 복지', '국경을\n강화하라!', '평화는\n무력으로!',
  '백투더 퓨처?', '젠킨스?', '문을 열어라!', '예를 갖춰\n대하라', '날씨가\n좋구나',
  '오늘 점심이\n무엇이냐?', '귀찮구나', '밥 줘', '짐의 나이가\n궁금한가?', '혁명을\n일으키겠다',
  '왕보다 낮은\n사람 접어', '내가 왕이될\n상인가', '부모도\n실력이다'];
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
          fontSize: 18,
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
