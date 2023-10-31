import 'package:kingmaker/dto/test_dto.dart';

import 'package:flutter/material.dart';
import 'package:kingmaker/repository/test_repository.dart';

class TestProvider with ChangeNotifier {
  late final TestRepository _testRepository;
  TestDto _testDto = TestDto(age: -1, name: "", city: ""); // 초기 데이터 저장
  TestDto get testDto => _testDto;
  TestProvider() {
    _testRepository = TestRepository();
    getData(); // Provider생성과 동시에 데이터 가져오는 함수
  } 
  Future<void> getData() async {
      TestDto test = (await _testRepository.getData()) as TestDto;
      _testDto = test;
      notifyListeners();
      print('Provider에서의 데이터');
      print(test.toString());
      print('============================');
  }
}