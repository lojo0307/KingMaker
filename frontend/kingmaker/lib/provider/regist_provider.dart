import 'package:flutter/material.dart';
import 'package:kingmaker/dto/routine_dto.dart';
import 'package:kingmaker/dto/todo_dto.dart';
import 'package:kingmaker/repository/routine_repository.dart';
import 'package:kingmaker/repository/todo_repository.dart';

class RegistProvider with ChangeNotifier {
  late final RoutineRepository _routineRepository;
  late final TodoRepository _todoRepository;
  String _title = "";
  String get title => _title;

  String _detail = "";
  String get detail => _detail;

  int _categoryId = 1;
  int get categoryId => _categoryId;

  bool _importantYn = false;
  bool get importantYn => _importantYn;

  String _startAt = "";
  String get startAt => _startAt;

  String _endAt = "";
  String get endAt => _endAt;

  String _type = "day";
  String get type => _type;

  dynamic  _value = 0;
  dynamic get value => _value;

  String _startTime = "";
  String get startTime => _startTime;

  String _endTime = "";
  String get endTime => _endTime;


  RegistProvider() {
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }

  RegistRoutine(int MemberId){
    String period = "{\"type\" : \"$_type\", \"value\": $_value}";
    RoutineDto routine = RoutineDto(routineId: 0, categoryId: _categoryId, routineNm: _title, routineDetail: _detail, period: period, importantYn: _importantYn, startAt: '${_startAt}09:00:00', endAt: '${_endAt}23:59:59');
    _routineRepository.registRoutine(MemberId, routine);
    ResetAll();
  }

  RegistTodo(int MemberId){
    TodoDto todoDto = TodoDto(todoId: 0, categoryId: _categoryId, startAt: '$_startAt$_startTime', endAt: '$_endAt$_endTime', todoNm: _title, todoDetail: _detail, todoPlace: "장소", importantYn: importantYn, achievedYn: false);
    print(todoDto.startAt);
    _todoRepository.registTodo(MemberId, todoDto);
    ResetAll();
  }

  void ResetAll() {
    _title = "";
    _detail = "";
    _categoryId = 1;
    _importantYn = false;
    _startAt = "";
    _endAt = "";
    _type = "day";
    _value = 0;
  }

  void setTitle(String value) {
    _title = value;
  }

  void setDetail(String value) {
    _detail = value;
  }

  void setCategoryId(int value) {
    _categoryId = value;
  }
  void setStart(String format) {
    _startAt = format;
  }
  void setEnd(String format) {
    _endAt = format;
  }

  void setType(String value) {
    switch (value){
      case '주 단위':
        _type = 'day';
        break;
      case '일 단위':
        _type = 'num';
        break;
      case '월 단위':
        _type = 'month';
        break;
    }
  }

  void setValue(dynamic selections1) {
    _value = selections1;
  }

  void changeImport() {
    _importantYn = !_importantYn;
  }

  void setStartTime(String format) {
    _startTime = format;
  }

  void setEndTime(String format) {
    _endTime = format;
  }
}