import 'package:kingmaker/api/test_api.dart';
import 'package:kingmaker/dto/test_dto.dart';

class TestRepository {
  final TestApi _testApi = TestApi();

  Future<TestDto> getData() {
    return _testApi.getData();
  }
}