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

  getAllData(int memberId) {
    getCategory(memberId);
    getDailyRate(memberId);
    getMonthlyRate(memberId);
    getYearRate(memberId);
    getAchieveList(memberId);
    notifyListeners();
  }
  getCategory(memberId) async {
    List<String> categories = await _achievementRepository.getCategory(memberId);
    _maxCategory = categories.first;
    _minCategory = categories.last;
    notifyListeners();
  }
  getDailyRate(memberId) async {
    _dailyRate = await _achievementRepository.getDailyRate(memberId);
    if (_dailyRate == -1) {
      _dailyRate = 0;
    }
    notifyListeners();
  }
  getMonthlyRate(memberId) async {
    _monthlyRate = await _achievementRepository.getMonthlyRate(memberId);
    if (_monthlyRate == -1) {
      _monthlyRate = 0;
    }
    notifyListeners();
  }
  getYearRate(memberId) async {
    _yearRate = await _achievementRepository.getYearRate(memberId);
    if (_yearRate == -1) {
      _yearRate = 0;
    }
    notifyListeners();
  }
  getAchieveList(memberId) async {
    _list = await _achievementRepository.getAchieveList(memberId);
    notifyListeners();
  }
}