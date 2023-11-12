import 'package:flutter/material.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/repository/achievement_repository.dart';

class AchievementProvider with ChangeNotifier {
  late final AchievementRepository _achievementRepository;

  String _maxCategory = "";
  String get maxCategory => _maxCategory;
  String _minCategory = "";
  String get minCategory => _minCategory;
  int _dailyRate = 0;
  int get dailyRate => _dailyRate;
  int _monthlyRate = 0;
  int get monthlyRate => _monthlyRate;
  int _yearRate = 0;
  int get yearRate => _yearRate;

  List<RewardDto> _list = [];
  List<RewardDto> get list => _list;

  AchievementProvider() {
    _achievementRepository = AchievementRepository();
  }

  void getAllData(int memberId) {
    getMaxCategory(memberId);
    getMinCategory(memberId);
    getDailyRate(memberId);
    getMonthlyRate(memberId);
    getYearRate(memberId);
    getAchieveList(memberId);
  }
  getMaxCategory(memberId) async {
    _maxCategory = await _achievementRepository.getMaxCategory(memberId);
    notifyListeners();
  }
  getMinCategory(memberId) async {
    _minCategory = await _achievementRepository.getMinCategory(memberId);
    notifyListeners();
  }
  getDailyRate(memberId) async {
    _dailyRate = await _achievementRepository.getDailyRate(memberId);
    notifyListeners();
  }
  getMonthlyRate(memberId) async {
    _monthlyRate = await _achievementRepository.getMonthlyRate(memberId);
    notifyListeners();
  }
  getYearRate(memberId) async {
    _yearRate = await _achievementRepository.getYearRate(memberId);
    notifyListeners();
  }
  getAchieveList(memberId) async {
    _list = await _achievementRepository.getAchieveList(memberId);
    notifyListeners();
  }
}