import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class AlarmApi{
  void getAlarmState(int memberId) async{
    final response = await dio.get(
      '$url/api/mypage/notification/$memberId',
    );
  }

  void setAlarm(int memberId, int notificationTypeId) async{
    final response = await dio.get(
      '$url/api/notification/setting',
      data: {
        "memberId" : memberId,
        "notificationTypeId" : notificationTypeId,
      }
    );
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

