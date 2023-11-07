import 'package:kingmaker/api/calendar_api.dart';

class CalendarRepository {
  final CalendarApi _calendarApi = CalendarApi();

  Future<Map<String, int>> getList(int memberId, int year, int month) {
    return _calendarApi.getCalendarTodo(memberId, year, month);
  }

}