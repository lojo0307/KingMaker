import 'package:kingmaker/api/reward_api.dart';

class AchievementRepository {
  final RewardApi _rewardApiApi = RewardApi();

  Future<String> getMaxCategory(int memberId) {
    return _rewardApiApi.getMaxCategory(memberId);
  }

  Future<String> getMinCategory(int memberId){
    return _rewardApiApi.getMinCategory(memberId);
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