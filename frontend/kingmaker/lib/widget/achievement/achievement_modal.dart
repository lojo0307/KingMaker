import 'package:flutter/material.dart';
// import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:kingmaker/dto/reward_dto.dart';

import 'achievement_modal_widget.dart';

class AchievementModal {
  static void showAchievementDialog({
    required BuildContext context,
    required RewardDto data,
    DialogTransitionType transitionType = DialogTransitionType.scale,
    Curve curve = Curves.fastOutSlowIn,
    Duration duration = const Duration(seconds: 1),
  }) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        print('여기가 모달 진짜 호출 하는 곳');
        return AchievementModalWidget(dto: data,);
      },
      animationType: transitionType,
      curve: curve,
      duration: duration,
    );
  }
}
