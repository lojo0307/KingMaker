import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import '../dto/test_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class TestApi{
  Future<TestDto> getData() async{
    final response = await dio.get(
        '$url/api/test',
    );
    print('API에서의 데이터');
    print(response.data);
    print(response.data['data'].runtimeType);
    print('============================');
    return TestDto.fromJson(response.data['data']);
  }
}

