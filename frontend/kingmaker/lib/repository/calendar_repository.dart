import 'package:kingmaker/api/calendar_api.dart';

class CalendarRepository {
  final CalendarApi _calendarApi = CalendarApi();

  Future<Map<String, int>> getData(int memberId, int year, int month) {
    return _calendarApi.getCalendarTodo(memberId, year, month);
  }

  Future<Map<String, int>> getMyCal(int memberId, int year, int month) {
    return _calendarApi.getCalendarAchieve(memberId, year, month);
  }
}