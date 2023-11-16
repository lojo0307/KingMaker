import 'package:flutter/material.dart';
import 'package:kingmaker/dto/alarm_dto.dart';
import 'package:kingmaker/repository/alarm_repository.dart';

class AlarmProvider with ChangeNotifier {
  late final AlarmRepository _alarmRepository;

  List<AlarmDto> _list = [];
  List<AlarmDto> get list => _list;

  AlarmProvider() {
    _alarmRepository = AlarmRepository();
  }

  getAlarm(int memberId) async{
    _list = await _alarmRepository.getAlarm(memberId);
    notifyListeners();
  }
  deleteAlarm(int notificationId) async {
    await _alarmRepository.deleteAlarm(notificationId);
  }

  deleteAll() {
    for(int i = 0 ; i < _list.length ; i++){
      deleteAlarm(_list.elementAt(i).notificationId);
    }
    _list = [];
    notifyListeners();
  }
}