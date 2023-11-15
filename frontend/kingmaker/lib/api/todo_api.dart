import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/dto/todo_dto.dart';
import 'package:kingmaker/widget/achievement/test_modal.dart';

class TodoApi{
  final TotalApi totalApi = TotalApi();
  final TestModal testModal = TestModal();

  Future<List<TodoDto>> getList(int memberId, String date) async {
    try{
      final response = await totalApi.getApi('/api/todo/list/$memberId?date=$date',);
      return response.data['data'].map<TodoDto>((memberTodo) {
        return TodoDto.fromJsonToListDto(memberTodo);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }
  void registTodo(int memberId, TodoDto todoDto) async {
    final response = await totalApi.postApi('/api/todo', todoDto.toRegistJson(memberId),);
    print('Todo Api registTodo response : $response');
    if (response.data['data']['rewardResDtoList'] != null){
      for(int i = 0 ; i < response.data['data']['rewardResDtoList'].length ; i++){
        testModal.getViewModel(
            RewardDto.fromJson(response.data['data']['rewardResDtoList'].elementAt(i)['rewardInfoDto'])
        );
      }
    }
  }

  void modifyTodo(TodoDto todoDto) async{
    final response = await totalApi.putApi('/api/todo', todoDto.toModifytJson(),);
  }

  void deleteTodo(int todoId) async{
    final response = await totalApi.deleteApi('/api/todo?todoId=$todoId',);
  }

  Future<TodoDto> detailTodo(int todoId) async{
    try{
      final response = await totalApi.getApi('/api/todo/$todoId',);
      return TodoDto.fromJson(todoId, response.data['data']);
    } catch (e) {
      print(e);
      return {} as TodoDto;
    }
  }

  void achieveTodo(int todoId) async{
    final response = await totalApi.patchApi1('/api/todo/$todoId',);
    if (response.data['data']['rewardResDtoList'] != null){
      for(int i = 0 ; i < response.data['data']['rewardResDtoList'].length ; i++){
        testModal.getViewModel(
            RewardDto.fromJson(response.data['data']['rewardResDtoList'].elementAt(i)['rewardInfoDto'])
        );
      }
    }
  }
}

