import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:kingmaker/dto/todo_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class TodoApi{
  Future<List<TodoDto>> getList(int memberId, String date) async{
    try{
      print('todo1');
      final response = await dio.get(
        '$url/api/todo/list/$memberId?date=$date',
      );
      print('todo2');
      return response.data['data'].map<TodoDto>((memberTodo) {
        return TodoDto.fromJsonToListDto(memberTodo);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }

  void registTodo(int memberId, TodoDto todoDto) async{
    print(todoDto);
    final response = await dio.post(
      '$url/api/todo',
      data: todoDto.toRegistJson(memberId),
    );
  }

}

