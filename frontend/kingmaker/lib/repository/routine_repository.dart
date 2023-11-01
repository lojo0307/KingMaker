import 'package:kingmaker/api/routine_api.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';


class RoutineRepository {
  final RoutineApi _routineApi = RoutineApi();

  Future<List<MemberRoutineDto>> getList(int memberId, String date) {
    return _routineApi.getData(memberId, date);
  }
}