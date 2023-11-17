import 'package:kingmaker/api/reward_api.dart';

class AchievementRepository {
  final RewardApi _rewardApiApi = RewardApi();

  Future<List<String>> getCategory(int memberId) {
    return _rewardApiApi.getCategory(memberId);
  }

  getDailyRate(int memberId) {
    return _rewardApiApi.getDailyAchieve(memberId);
  }

  getMonthlyRate(int memberId) {
    return _rewardApiApi.getMonthlyAchieve(memberId);
  }

  getYearRate(int memberId) {
    return _rewardApiApi.getyearlyAchieve(memberId);
  }

  getAchieveList(int memberId) {
    return _rewardApiApi.getAllReward(memberId);
  }

}