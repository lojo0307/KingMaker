import 'package:kingmaker/api/todo_api.dart';
import 'package:kingmaker/dto/todo_dto.dart';

class TodoRepository {
  final TodoApi _todoApi = TodoApi();

  Future<List<TodoDto>> getList(int memberId, String date) {
    return _todoApi.getList(memberId, date);
  }

  void registTodo(int memberId, TodoDto todoDto) {
    _todoApi.registTodo(memberId, todoDto);
  }

  void achieve(todoId) {
    _todoApi.achieveTodo(todoId);
  }

  Future<TodoDto> getDetail(int id) {
    return _todoApi.detailTodo(id);
  }

  void deleteTodo(int id) {
    return _todoApi.deleteTodo(id);
  }

}