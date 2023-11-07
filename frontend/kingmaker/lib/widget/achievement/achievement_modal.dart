import 'package:flutter/material.dart';
// import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'achievement_modal_widget.dart';

class AchievementModal {
  static void showAchievementDialog({
    required BuildContext context,
    required String title,
    required String content,
    DialogTransitionType transitionType = DialogTransitionType.scale,
    Curve curve = Curves.fastOutSlowIn,
    Duration duration = const Duration(seconds: 1),
  }) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AchievementModalWidget(title: title, content: content,);
      },
      animationType: transitionType,
      curve: curve,
      duration: duration,
    );
  }
}
