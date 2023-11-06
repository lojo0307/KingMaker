import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class CalendarApi{
  void getCalendarTodo(int memberId, int year, int month) async{
    final response = await dio.get(
      '$url/api/todo/calendar/$memberId?year=$year&month=$month',
    );
  }

  void getCalendarAchieve(int memberId, int year, int month) async{
    final response = await dio.get(
      '$url/api/mypage/calendar/$memberId?year=$year&month=$month',
    );
  }
}

