import 'package:flutter/material.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/todo_dto.dart';
import 'package:kingmaker/repository/routine_repository.dart';
import 'package:kingmaker/repository/todo_repository.dart';

class ScheduleProvider with ChangeNotifier {
  late final RoutineRepository _routineRepository;
  late final TodoRepository _todoRepository;

  List<Map<String, String>> _list = []; // 초기 데이터 저장
  List<Map<String, String>> get list => _list;
  List<MemberRoutineDto> _rList = [];
  List<MemberRoutineDto> get rList => _rList;
  List<TodoDto> _tList = [];
  List<TodoDto> get tList => _tList;
  Map<String, String> _detail = {};
  Map<String, String> get detail => _detail;

  ScheduleProvider() {
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }

  getList(int memberId, int year, int month, int day) async{
    String monStr = month < 10 ? '0$month' : month.toString();
    String daytr = day < 10 ? '0$day' : day.toString();
    _rList = await _routineRepository.getList(memberId, '$year-$monStr-$daytr 00:00:00');
    _tList = await _todoRepository.getList(memberId, '${year%100}$monStr$daytr');
    make(list);
  }
 getMainList(int memberId, int year, int month, int day) async {
    try {
      String monStr = month < 10 ? '0$month' : month.toString();
      String dayStr = day < 10 ? '0$day' : day.toString();
      _rList = await _routineRepository.getList(memberId, '$year-$monStr-$dayStr 00:00:00');
      _tList = await _todoRepository.getList(memberId, '${year%100}$monStr$dayStr');
      // 데이터를 가져오는 데 성공했습니다.

      print('ScheduleProvider - getList : $_tList');
      make(list);
      print('ScheduleProvider - getList2 :$_list');
    } catch (e) {
      // 에러가 발생했습니다.
      print("error getMainList 발생 $e");
    }
  }


  void make(List<Map<String, String>> list) {
    int ridx = 0;
    int tidx = 0;
    List<Map<String, String>> achiveList = [];
    List<Map<String, String>> noneAchiveList = [];
    while (ridx < rList.length && tidx < tList.length){
      if (rList.elementAt(ridx).routine.startAt.compareTo(tList.elementAt(tidx).startAt) < 0){
        MemberRoutineDto dto = rList.elementAt(ridx);
        Map<String, String> value = makeValueFromRoutine(dto);
        if (rList.elementAt(ridx).achievedYn){
          achiveList.add(value);
        }
        else {
          noneAchiveList.add(value);
        }
        ridx++;
      } else {
        TodoDto dto = tList.elementAt(tidx);
        Map<String, String> value = makeValueFromTodo(dto);
        if (tList.elementAt(tidx).achievedYn){
          achiveList.add(value);
        } else {
          noneAchiveList.add(value);
        }
        tidx++;
      }
    }
    while (ridx < rList.length){
      MemberRoutineDto dto = rList.elementAt(ridx);
      Map<String, String> value = makeValueFromRoutine(dto);
      if (rList.elementAt(ridx).achievedYn){
        achiveList.add(value);
      }
      else {
        noneAchiveList.add(value);
      }
      ridx++;
    }
    while (tidx < tList.length){
      TodoDto dto = tList.elementAt(tidx);
      Map<String, String> value = makeValueFromTodo(dto);
      if (tList.elementAt(tidx).achievedYn){
        achiveList.add(value);
      } else {
        noneAchiveList.add(value);
      }
      tidx++;
    }
    _list = noneAchiveList + achiveList;
    print("#########makelist : $_list");
    notifyListeners();
  }

  Map<String, String> makeValueFromRoutine(MemberRoutineDto dto) {
    return {
      'id' : dto.memberRoutineId.toString(),
      'memberId' : dto.routine.routineId.toString(),
      'title' : dto.routine.routineNm,
      'type' : '2',
      'category' : dto.routine.categoryId.toString(),
      'start' : makeTime(dto.routine.startAt),
      'end' : makeTime(dto.routine.endAt),
      'important' : dto.importantYn? '1':'0',
      'achieved' : dto.achievedYn? '1' : '0',
    };
  }

  Map<String, String> makeValueFromTodo(TodoDto dto) {
    return {
      'id' : dto.todoId.toString(),
      'title' : dto.todoNm,
      'type' : '1',
      'category' : dto.categoryId.toString(),
      'start' : makeTime(dto.startAt),
      'end' : makeTime(dto.endAt),
      'important' : dto.importantYn? '1':'0',
      'achieved' : dto.achievedYn? '1' : '0',
    };
  }

  makeTime(String timeString) {
    int i = 0;
    while(timeString.codeUnitAt(i)!= "T".codeUnitAt(0) && timeString.codeUnitAt(i)!= " ".codeUnitAt(0)){
      i++;
    }
    i++;
    int hour = timeString.codeUnitAt(i++) - 48;
    hour = hour * 10 + timeString.codeUnitAt(i++) - 48;
    i++;
    int min = timeString.codeUnitAt(i++) - 48;
    min = min * 10 + timeString.codeUnitAt(i++) - 48;
    return "$hour시 $min분";
  }

  void achieveRoutine(int memberRoutineId) {
    _routineRepository.achieve(memberRoutineId);
    for(int i = 0 ; i < _rList.length; i++){
      if (_rList.elementAt(i).memberRoutineId == memberRoutineId){
        _rList.elementAt(i).achievedYn = _rList.elementAt(i).achievedYn? false : true;
        break;
      }
    }
    make(list);
  }

  void achieveTodo(int todoId) {
    _todoRepository.achieve(todoId);
    for(int i = 0 ; i < _tList.length; i++){
      if (_tList.elementAt(i).todoId == todoId){
        _tList.elementAt(i).achievedYn = _tList.elementAt(i).achievedYn? false : true;
        break;
      }
    }
    make(list);
  }

  getDetail(int id, String type) async {
    if (type == '2'){
      MemberRoutineDto routineDetail = await _routineRepository.getDetail(id);
      _detail = {
        'id' : id.toString(),
        'type' : '2',
        'title' : routineDetail.routine.routineNm,
        'startAt' : makedate(routineDetail.routine.startAt),
        'endAt' : makedate(routineDetail.routine.endAt),
        'importantYn' : routineDetail.routine.importantYn.toString(),
        'detail' : routineDetail.routine.routineDetail,
        'category' : routineDetail.routine.categoryId.toString(),
        'achievedYn' : routineDetail.achievedYn.toString(),
      };
    } else {
      TodoDto todoDetail = await _todoRepository.getDetail(id);
      _detail = {
        'id' : id.toString(),
        'type' : '1',
        'title' : todoDetail.todoNm,
        'startAt' : makedate(todoDetail.startAt),
        'endAt' : makedate(todoDetail.endAt),
        'importantYn' : todoDetail.importantYn.toString(),
        'detail' : todoDetail.todoDetail,
        'category' : todoDetail.categoryId.toString(),
        'place' : todoDetail.todoPlace,
        'achievedYn' : todoDetail.achievedYn.toString(),
      };
    }
  }
  makedate(String date){
    return " ${date.substring(0,4)}년 ${date.substring(5,7)}월 ${date.substring(8,10)}일";
  }

  void changeAchieve() {
    _detail['achievedYn'] = (_detail['achievedYn'] == 'true')? 'false' : 'true';
  }
}