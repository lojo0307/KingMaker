import 'package:flutter/material.dart';
import 'package:kingmaker/dto/routine_dto.dart';
import 'package:kingmaker/dto/todo_dto.dart';
import 'package:kingmaker/repository/routine_repository.dart';
import 'package:kingmaker/repository/todo_repository.dart';
import 'package:intl/intl.dart';

class RegistProvider with ChangeNotifier {
  late final RoutineRepository _routineRepository;
  late final TodoRepository _todoRepository;

  int _id = 0;
  int get id => _id;

  String _title = "";
  String get title => _title;

  String _detail = "";
  String get detail => _detail;

  int _categoryId = 1;
  int get categoryId => _categoryId;

  bool _importantYn = false;
  bool get importantYn => _importantYn;

  bool _achievedYn = false;
  bool get achievedYn => _achievedYn;

  String _startAt = "";
  String get startAt => _startAt;

  String _endAt = "";
  String get endAt => _endAt;

  String _type = "day";
  String get type => _type;

  dynamic  _value = 0;
  dynamic get value => _value;

  String _startTime = '';
  String get startTime => _startTime;

  String _endTime = '';
  String get endTime => _endTime;

  DateTime? _startDay;
  DateTime? get startDay => _startDay;
  DateTime? _endDay;
  DateTime? get endDay => _endDay;

  String _error1 = "";
  String get error1 => _error1;
  String _error2 = "";
  String get error2 => _error2;
  String _error3 = "";
  String get error3 => _error3;
  String _error4 = "";
  String get error4 => _error4;


  RegistProvider() {
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }

  RegistRoutine(int MemberId){
    print(value);
    print(value.runtimeType);
    if (_title == "")
      _error1 = "제목을 작성해 주세요.";
    if(_detail == "")
      _error2 = "상세 내용을 작성해 주세요.";
    if(_startAt == "" || _endAt == "")
      _error3 = "날짜를 입력해 주세요.";
    if (_type != "day" && (_value == '0' || value == 0 || value.runtimeType == List<bool>))
      _error4 = "주기를 작성해 주세요.";
    if (_type == "day" && value.runtimeType != List<bool>)
      _error4 = "요일을 작성해 주세요.";
    if (_type == "day" && value.runtimeType == List<bool>){
      bool flag = false;
      for(int i = 0 ; i < 7 ; i++){
        if (value[i])
          flag = true;
      }
      if (!flag)
        _error4 = "요일을 작성해 주세요.";
    }
    if (_error1 != "" || _error2 != "" || _error3 != "" || _error4 != ""){
      notifyListeners();
      return -1;
    }
    String period = "{\"type\" : \"$_type\", \"value\": $_value}";
    RoutineDto routine = RoutineDto(routineId: 0, categoryId: _categoryId, routineNm: _title, routineDetail: _detail, period: period, importantYn: _importantYn, startAt: "${_startAt}00:00:00", endAt: "${_endAt}23:59:59");
    _routineRepository.registRoutine(MemberId, routine);
    ResetAll();
    return 1;
  }

  ModifyRoutine(int _routineId){
    // if (_title == "")
    //   _error1 = "제목을 작성해 주세요.";
    // if(_detail == "")
    //   _error2 = "상세 내용을 작성해 주세요.";
    // if(_startAt == "" || _endAt == "")
    //   _error3 = "날짜를 입력해 주세요.";
    // if (_type != "day" && (_value == '0' || value == 0 || value.runtimeType == List<bool>))
    //   _error4 = "주기를 작성해 주세요.";
    // if (_type == "day" && value.runtimeType != List<bool>)
    //   _error4 = "요일을 작성해 주세요.";
    // if (_type == "day" && value.runtimeType == List<bool>){
    //   bool flag = false;
    //   for(int i = 0 ; i < 7 ; i++){
    //     if (value[i])
    //       flag = true;
    //   }
    //   if (!flag)
    //     _error4 = "요일을 작성해 주세요.";
    // }
    // if (_error1 != "" || _error2 != "" || _error3 != "" || _error4 != ""){
    //   notifyListeners();
    //   return -1;
    // }
    // String period = "{\"type\" : \"$_type\", \"value\": $_value}";
    RoutineDto routine = RoutineDto(routineId: _routineId, categoryId: _categoryId, routineNm: _title, routineDetail: _detail, period: period, importantYn: _importantYn, startAt: "${_startAt}00:00:00", endAt: "${_endAt}23:59:59");
    _routineRepository.modifyRoutine(routine);
    ResetAll();
    return 1;
  }

  RegistTodo(int MemberId){
    if (_title == "")
      _error1 = "제목을 작성해 주세요.";
    if(_detail == "")
      _error2 = "상세 내용을 작성해 주세요.";
    if(_startAt == "" || _endAt == "")
      _error3 = "날짜를 입력해 주세요.";
    else if (_startTime == "" || _endTime == "")
      _error3 = "시간을 입력해 주세요.";
    if (_error1 != "" || _error2 != "" || _error3 != ""){
      notifyListeners();
      return -1;
    }
    TodoDto todoDto = TodoDto(todoId: 0, categoryId: _categoryId, startAt: "$_startAt$_startTime", endAt: "$_endAt$_endTime", todoNm: _title, todoDetail: _detail, todoPlace: "장소", importantYn: importantYn, achievedYn: achievedYn);
    _todoRepository.registTodo(MemberId, todoDto);
    ResetAll();
    return 1;
  }

  ModifyTodo(int _todoId){
    //todoId는 줘야 함
    TodoDto todoDto = TodoDto(todoId: _todoId, categoryId: _categoryId, startAt: "$_startAt$_startTime", endAt: "$_endAt$_endTime", todoNm: _title, todoDetail: _detail, todoPlace: "장소", importantYn: importantYn, achievedYn: false);
    _todoRepository.modifyTodo(todoDto);
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
    _startTime = '';
    _endTime = '';
    _error1 = "";
    _error2 = "";
    _error3 = "";
    _error4 = "";
  }

  void setData(Map<String, String> detail) {
    _id = int.parse(detail['id']!);
    _title = detail['title']!;
    _detail = detail['detail']!;
    _categoryId = int.parse(detail['category']!);
    _importantYn = bool.parse(detail['importantYn']!);
    _startDay = DateTime.parse(detail['startAtString']!);
    _endDay = DateTime.parse(detail['endAtString']!);
    _startAt = DateFormat('yyyy-MM-ddT').format(_startDay!);
    _endAt = DateFormat('yyyy-MM-ddT').format(_endDay!);
    _startTime = DateFormat('hh:mm').format(_startDay!);
    _endTime = DateFormat('hh:mm').format(_endDay!);
    _achievedYn = bool.parse(detail['achievedYn']!);
  }

  void setTitle(String value) {
    _title = value;
    _error1 = "";
    notifyListeners();
  }

  void setDetail(String value) {
    _detail = value;
    _error2 = "";
    notifyListeners();
  }

  void setCategoryId(int value) {
    _categoryId = value;
  }
  void setStart(String format) {
    _startAt = format;
    _error3 = "";
    notifyListeners();
  }
  void setEnd(String format) {
    _endAt = format;
    _error3 = "";
    notifyListeners();
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
    _error4 = "";
    notifyListeners();
  }

  void setValue(dynamic selections) {
    _value = selections;
    _error4 = "";
    notifyListeners();
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