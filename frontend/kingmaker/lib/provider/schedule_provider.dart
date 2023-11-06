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
  ScheduleProvider() {
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }
  getList() async{
    DateTime now = DateTime.now();
    print(now);
    _rList = await _routineRepository.getList(1, "2023-11-06 00:00:00");
    _tList = await _todoRepository.getList(1, "231106");
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
    _list = achiveList + noneAchiveList;
  }

  Map<String, String> makeValueFromRoutine(MemberRoutineDto dto) {
    return {
      'title' : dto.routine.routineNm,
      'type' : '2',
      'category' : dto.routine.categoryId.toString(),
      'start' : makeTime(dto.routine.startAt),
      'end' : makeTime(dto.routine.endAt),
      'achieved' : dto.achievedYn? '1' : '0',
    };
  }

  Map<String, String> makeValueFromTodo(TodoDto dto) {
    return {
      'title' : dto.todoNm,
      'type' : '1',
      'category' : dto.categoryId.toString(),
      'start' : '9시 40분',
      'end' : '11시 23분',
      'achieved' : dto.achievedYn? '1' : '0',
    };
  }

  makeTime(String timeString) {
    print(timeString);
    return "";
  }
}