
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';

import 'package:kingmaker/widget/main/main_game.dart';

class MainPlayer extends SpriteComponent with TapCallbacks {
  static Vector2 spriteSize = Vector2(128, 128);
  final MyGame game;

  late SpriteComponent spriteComponent;
  late TextComponent textComponent;

  MainPlayer(this.game);

  @override
  Future<void> onLoad() async {
      sprite = await Sprite.load('male.png');
      size = Vector2(65,110);
      position = Vector2(452, 300);
      textComponent=TextComponent(text: "엄준식");
      await textComponent.onLoad();
      final textWidth = textComponent.width;
      textComponent.position.setValues((size.x / 2) - (textWidth / 2),
          120);
      add(textComponent);
  }

  @override
  void onTapUp(TapUpEvent event) {
    Vector2 worldPosition = game.camera.localToGlobal(event.localPosition);
    if (toRect().contains(worldPosition.toOffset())) {
      print('player onTapUp called');
      // toggleAnimationRow();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

}
