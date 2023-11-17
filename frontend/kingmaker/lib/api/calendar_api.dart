import 'package:kingmaker/api/total_api.dart';

class CalendarApi{
  final TotalApi totalApi = TotalApi();
  Future<Map<String, int>> getCalendarTodo(int memberId, int year, int month) async{
    Map<String, int> res = {};
    try{
      final response = await totalApi.getApi('/api/todo/calendar/$memberId?year=$year&month=$month');
      for(int i = 0 ; i < response.data['data'].length ; i++){
        String key = response.data['data'][i]['day'].toString();
        int value = response.data['data'][i]['level'];
        res[key] = value;
      }
      return res;
    } catch(e) {
      print(e);
    }
    return res;
  }

  Future<Map<String, int>> getCalendarAchieve(int memberId, int year, int month) async{
    Map<String, int> res = {};
    try{
      final response = await totalApi.getApi( '/api/mypage/calendar/$memberId?year=$year&month=$month',
      );
      for(int i = 0 ; i < response.data['data'].length ; i++){
        String key = response.data['data'][i]['day'].toString();
        int value = response.data['data'][i]['level'];
        res[key] = value;
      }
      return res;
    } catch(e) {
      print(e);
    }
    return res;
  }

}

