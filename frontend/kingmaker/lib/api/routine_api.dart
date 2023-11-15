import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/dto/routine_dto.dart';
import 'package:kingmaker/widget/achievement/test_modal.dart';

class RoutineApi{
  final TotalApi totalApi = TotalApi();
  final TestModal testModal = TestModal();

  Future <List<MemberRoutineDto>> getData(int memberId, String date) async{
    try{
      final response = await totalApi.getApi('/api/routine/$memberId?date=$date',);
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
    print(response.data['data']['rewardResDtoList']);
    print(response.data['data']['rewardResDtoList'] == null);
    if (response.data['data']['rewardResDtoList'] != null){
      for(int i = 0 ; i < response.data['data']['rewardResDtoList'].length ; i++){
        testModal.getViewModel(
            RewardDto.fromJson(response.data['data']['rewardResDtoList'].elementsAt(i))
        );
      }
    }
    print('routine 등록 완료');
  }

  void modifyRoutine(RoutineDto routine) async {
    final response = await totalApi.putApi('/api/routine', routine.toModifyJson(),);
  }

  void deleteRoutine(int routineId) async {
    final response = await totalApi.deleteApi('/api/routine/$routineId',);
  }

  void acheiveRoutine(int memberRoutineId) async {
    final response = await totalApi.patchApi1('/api/routine/$memberRoutineId',);
    if (response.data['data']['rewardResDtoList'] != null){
      for(int i = 0 ; i < response.data['data']['rewardResDtoList'].length ; i++){
        testModal.getViewModel(
            RewardDto.fromJson(response.data['data']['rewardResDtoList'].elementsAt(i))
        );
      }
    }
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

