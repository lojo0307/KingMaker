import 'package:kingmaker/api/total_api.dart';

class AlarmApi{
  final TotalApi totalApi = TotalApi();
  void getAlarmState(int memberId) async{
    final response = await totalApi.getApi('/api/mypage/notification/$memberId',);
  }

  void getAlarm(int memberId) async{
    final response = await dio.get(
        '$url/api/notification/$memberId',
    );
  }

  void deleteAlarm(int notificationId) async{
    final response = await dio.get(
      '$url/api/notification/$notificationId',
    );
  }
}

