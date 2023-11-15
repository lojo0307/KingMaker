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

  String _startTime = '00:00';
  String get startTime => _startTime;

  String _endTime = '23:59';
  String get endTime => _endTime;

  String _error = "";
  String get error => _error;

  RegistProvider() {
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }

  RegistRoutine(int MemberId){
    if (_title == "")
      _error = "제목을 작성해 주세요.";
    else if(_detail == "")
      _error = "상세 내용을 작성해 주세요.";
    else if(_startAt == "" || _endAt == "")
      _error = "날짜를 입력해 주세요.";
    else if (_type != "day" && _value == 0)
      _error = "주기를 작성해 주세요.";
    if (_error != ""){
      notifyListeners();
      return -1;
    }
    String period = "{\"type\" : \"$_type\", \"value\": $_value}";
    RoutineDto routine = RoutineDto(routineId: 0, categoryId: _categoryId, routineNm: _title, routineDetail: _detail, period: period, importantYn: _importantYn, startAt: "${_startAt}00:00:00", endAt: "${_endAt}23:59:59");
    _routineRepository.registRoutine(MemberId, routine);
    ResetAll();
    return 1;
  }

  RegistTodo(int MemberId){
    if (_title == "")
      _error = "제목을 작성해 주세요.";
    else if(_detail == "")
      _error = "상세 내용을 작성해 주세요.";
    else if(_startAt == "" || _endAt == "")
      _error = "날짜를 입력해 주세요.";
    else if (_type != "day" && _value == 0)
      _error = "주기를 작성해 주세요.";
    if (_error != ""){
      notifyListeners();
      return -1;
    }
    TodoDto todoDto = TodoDto(todoId: 0, categoryId: _categoryId, startAt: "$_startAt$_startTime", endAt: "$_endAt$_endTime", todoNm: _title, todoDetail: _detail, todoPlace: "장소", importantYn: importantYn, achievedYn: false);
    _todoRepository.registTodo(MemberId, todoDto);
    ResetAll();
    return 1;
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
    _startTime = '00:00';
    _endTime = '23:59';
    _error = "";
  }

  void setTitle(String value) {
    _title = value;
    _error = "";
  }

  void setDetail(String value) {
    _detail = value;
    _error = "";
  }

  void setCategoryId(int value) {
    _categoryId = value;
    _error = "";
  }
  void setStart(String format) {
    _startAt = format;
    _error = "";
  }
  void setEnd(String format) {
    _endAt = format;
    _error = "";
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
    _error = "";
  }

  void setValue(dynamic selections) {
    _value = selections;
    _error = "";
  }

  void changeImport() {
    _importantYn = !_importantYn;
    _error = "";
  }

  void setStartTime(String format) {
    _startTime = format;
    _error = "";
  }

  void setEndTime(String format) {
    _endTime = format;
    _error = "";
  }
}