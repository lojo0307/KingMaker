import 'package:kingmaker/api/test_api.dart';
import 'package:kingmaker/dto/test_dto.dart';

class TodoRepository {
  final TestApi _testApi = TestApi();

  Future<TestDto> getList() {
    return _testApi.getData();
  }
}