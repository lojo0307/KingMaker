import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/alarm_dto.dart';

class AlarmApi{
  final TotalApi totalApi = TotalApi();
  void getAlarmState(int memberId) async{
    final response = await totalApi.getApi('/api/mypage/notification/$memberId',);
  }

  Future <List<AlarmDto>> getAlarm(int memberId) async{
    print('AlarmApi - fetAlarm');
    try{
      final response = await totalApi.getApi('/api/notification/$memberId',);
      print(response);
      return response.data['data'].map<AlarmDto>((alarm) {
        return AlarmDto.fromJson(alarm);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }

  void deleteAlarm(int notificationId) async{
    final response = await totalApi.deleteApi('/api/notification/$notificationId',);
  }
}

