import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/todo_dto.dart';

class TodoApi{
  final TotalApi totalApi = TotalApi();
  Future<List<TodoDto>> getList(int memberId, String date) async {
<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788
    print('todo');
    try{
      final response = await totalApi.getApi('/api/todo/list/$memberId?date=$date',);
      // print('!!!!!!!!!!!response : ${response.data['data']}');
=======
    try{
      final response = await totalApi.getApi('/api/todo/list/$memberId?date=$date',);
>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
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
  }

  void modifyTodo(TodoDto todoDto) async{
    final response = await totalApi.putApi('/api/todo', todoDto.toModifytJson(),);
  }

  void deleteTodo(int todoId) async{
    final response = await dio.delete('/api/todo?todoId=$todoId',);
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
  }
}

