import 'package:kingmaker/api/routine_api.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/routine_dto.dart';


class RoutineRepository {
  final RoutineApi _routineApi = RoutineApi();

  Future<List<MemberRoutineDto>> getList(int memberId, String date) {
    return _routineApi.getData(memberId, date);
  }

  void registRoutine(int memberId, RoutineDto routine) {
    return _routineApi.registRoutine(memberId, routine);
  }
}