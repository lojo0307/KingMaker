import 'package:kingmaker/api/alarm_api.dart';

class AlarmRepository {
  final AlarmApi _alarmApi = AlarmApi();

  getAlarm(int memberId) {
    return _alarmApi.getAlarm(memberId);
  }
  deleteAlarm(int notificationId){
    return _alarmApi.deleteAlarm(notificationId);
  }
}