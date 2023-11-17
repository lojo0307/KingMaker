import 'package:flame/components.dart';
import 'package:flame/game.dart';

class FocusArea extends PositionComponent {
  // FocusArea의 크기는 실제로 화면에 표시되지 않는, 카메라가 따라가는 포인트입니다.
  @override
  NotifyingVector2 get size => NotifyingVector2.zero();

  @override
  set position(Vector2 position) {
    super.position = position;
  }
}