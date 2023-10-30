import 'package:kingmaker/api/test_api.dart';
import 'package:kingmaker/dto/test_dto.dart';

class TestProvider{
  static int age = -1;
  static String name = "";
  static String city = "";
  static Future<TestDto?> getData() async {
    TestDto? test;
    try{
      test = (await TestApi.getData()) as TestDto;
      print('Provider에서의 데이터');
      print(test.toString());
      print('============================');
      age = test.age;
      name = test.name;
      city = test.city;
    } catch(e){
      print(e);
    }
    return test;
  }
}