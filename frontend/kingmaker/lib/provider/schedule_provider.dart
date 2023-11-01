import 'package:flutter/material.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/repository/routine_repository.dart';
import 'package:kingmaker/repository/todo_repository.dart';

class ScheduleProvider with ChangeNotifier {
  late final RoutineRepository _routineRepository;
  late final TodoRepository _todoRepository;

  List<Map<String, String>> _list = []; // 초기 데이터 저장
  List<Map<String, String>> get list => _list;

  ScheduleProvider() {
    _routineRepository = RoutineRepository();
    _todoRepository = TodoRepository();
  }
  getList() async{
    List<MemberRoutineDto> rList = await _routineRepository.getList(1, " ");
    List<MemberRoutineDto> tList = [];

  }
}