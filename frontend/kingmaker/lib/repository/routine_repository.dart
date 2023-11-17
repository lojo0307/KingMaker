import 'package:kingmaker/api/routine_api.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/routine_dto.dart';


class RoutineRepository {
  final RoutineApi _routineApi = RoutineApi();

  Future<List<MemberRoutineDto>> getList(int memberId, String date) {
    return _routineApi.getData(memberId, date);
  }

  void registRoutine(int memberId, RoutineDto routine) {
    _routineApi.registRoutine(memberId, routine);
  }

  void modifyRoutine(RoutineDto routine){
    _routineApi.modifyRoutine(routine);
  }

  void achieve(int memberRoutineId) {
    return _routineApi.acheiveRoutine(memberRoutineId);
  }

  Future<MemberRoutineDto> getDetail(int id) {
    return _routineApi.getDetailRoutine(id);
  }

  void deleteRoutine(int id) {
    return _routineApi.deleteRoutine(id);
  }
}