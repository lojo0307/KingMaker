import 'package:flutter/material.dart';
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
        return AchievementModalWidget(dto: data,);
      },
      animationType: transitionType,
      curve: curve,
      duration: duration,
    );
  }
}
