import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class CalendarApi{
  Future<Map<String, int>> getCalendarTodo(int memberId, int year, int month) async{
    Map<String, int> res = {};
    try{
      final response = await dio.get(
        '$url/api/todo/calendar/$memberId?year=$year&month=$month',
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

  Future<Map<String, int>> getCalendarAchieve(int memberId, int year, int month) async{
    Map<String, int> res = {};
    try{
      final response = await dio.get(
        '$url/api/mypage/calendar/$memberId?year=$year&month=$month',
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

