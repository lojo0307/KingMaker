import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/routine_dto.dart';

class RoutineApi{
  final TotalApi totalApi = TotalApi();
  Future <List<MemberRoutineDto>> getData(int memberId, String date) async{
    try{
      final response = await totalApi.getApi('/api/routine/$memberId?date=$date',);
<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788
      print('RoutineApi-- getData: ${response}');
=======
>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
      return response.data['data']['dailyRoutines'].map<MemberRoutineDto>((memberRoutine) {
        return MemberRoutineDto.fromJson(memberRoutine);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }

  void registRoutine(int memberId, RoutineDto routine) async {
    final response = await totalApi.postApi('/api/routine', routine.toRegistJson(memberId),);
  }

  void modifyRoutine(RoutineDto routine) async {
    final response = await totalApi.putApi('/api/routine', routine.toModifyJson(),);
  }

  void deleteRoutine(int routineId) async {
    final response = await totalApi.deleteApi('/api/routine/$routineId',);
  }

  void acheiveRoutine(int memberRoutineId) async {
    final response = await totalApi.patchApi1('/api/routine/$memberRoutineId',);
  }

  Future <MemberRoutineDto> getDetailRoutine(int memberRoutineId) async {
    try{
      final response = await totalApi.getApi('/api/routine/detail/$memberRoutineId',);
      return MemberRoutineDto.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return {} as MemberRoutineDto;
    }
  }
}

