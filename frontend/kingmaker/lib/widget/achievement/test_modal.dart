import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/main.dart';
import 'package:kingmaker/widget/achievement/achievement_modal.dart';

class TestModal {
  final context = navigatorKey.currentContext;
  getViewModel(RewardDto rewardDto){
    AchievementModal.showAchievementDialog(
      context: context!,
      data: rewardDto,
    );
  }
}