import 'package:flutter/material.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/todo_dto.dart';
import 'package:kingmaker/repository/calendar_repository.dart';
import 'package:kingmaker/repository/routine_repository.dart';
import 'package:kingmaker/repository/todo_repository.dart';

class CalendarProvider with ChangeNotifier {
  late final CalendarRepository _calendarRepository;
  late final RoutineRepository _routineRepository;
  late final TodoRepository _todoRepository;

  Map<String, int> _data = {};
  Map<String, int> get data => _data;

  Map<String, int> _mypage = {};
  Map<String, int> get mypage => _mypage;

  List<Map<String, String>> _list = [];
  List<Map<String, String>> get list => _list;
  List<MemberRoutineDto> _rList = [];
  List<MemberRoutineDto> get rList => _rList;
  List<TodoDto> _tList = [];
  List<TodoDto> get tList => _tList;

  CalendarProvider() {
    _calendarRepository = CalendarRepository();
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }

  getData(int memberId, int year, int month) async {
    _data = await _calendarRepository.getData(memberId, year, month);
    notifyListeners();
  }

  getMyCal(int memberId, int year, int month) async {
    _mypage = await _calendarRepository.getMyCal(memberId, year, month);
    notifyListeners();
  }

  getList(int memberId, int year, int month, int day) async{
    String monStr = month < 10 ? '0$month' : month.toString();
    String daytr = day < 10 ? '0$day' : day.toString();
    _rList = await _routineRepository.getList(memberId, '$year-$monStr-$daytr 00:00:00');
    _tList = await _todoRepository.getList(memberId, '${year%100}$monStr$daytr');
    make(list);
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
    notifyListeners();
  }

  Map<String, String> makeValueFromRoutine(MemberRoutineDto dto) {
    return {
      'id' : dto.memberRoutineId.toString(),
      'memberId' : dto.routine.routineId.toString(),
      'title' : dto.routine.routineNm,
      'category' : dto.routine.categoryId.toString(),
      'type' : '2',
      'important' : dto.importantYn? '1':'0',
      'achieved' : dto.achievedYn? '1' : '0',
    };
  }

  Map<String, String> makeValueFromTodo(TodoDto dto) {
    return {
      'id' : dto.todoId.toString(),
      'title' : dto.todoNm,
      'category' : dto.categoryId.toString(),
      'type' : '1',
      'important' : dto.importantYn? '1':'0',
      'achieved' : dto.achievedYn? '1' : '0',
    };
  }
}