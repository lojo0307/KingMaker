import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class TotalApi{
  final storage = const FlutterSecureStorage();

  getApi (String urlChecker) async{
    var headers = await getHeader();
    final response = await dio.get(
      '$url$urlChecker',
      options: Options(headers: headers),
    );
    if (response.data['code'] == '200') {
      return response;
    }
    if (response.data['code'] == '1707') {
      var headers1 = await getHeader2();
      final response1 = await dio.get(
        '$url$urlChecker',
        options: Options(headers: headers1),
      );
      if (response1.data['code'] == '200'){
        storage.write(key: "authorization", value: '${response1.headers['authorization']?.first}');
        storage.write(key: "authorization-refresh", value: '${response1.headers['authorization-refresh']}');
      }
      return response1;
    }
  }
  postApi (String urlChecker, registJson) async{
    var headers = await getHeader();
    final response = await dio.post(
      '$url$urlChecker',
      data: registJson,
      options: Options(headers: headers),
    );
    if (response.data['code'] == '200') {
      return response;
    }
    if (response.data['code'] == '1707') {
      var headers1 = await getHeader2();
      final response1 = await dio.post(
        '$url$urlChecker',
        data: registJson,
        options: Options(headers: headers1),
      );
      if (response1.data['code'] == '200'){
        storage.write(key: "authorization", value: '${response1.headers['authorization']?.first}');
        storage.write(key: "authorization-refresh", value: '${response1.headers['authorization-refresh']}');
      }
      return response1;
    }
  }
  putApi (String urlChecker, modifytJson) async{
    var headers = await getHeader();
    final response = await dio.put(
      '$url$urlChecker',
      options: Options(headers: headers),
        data: modifytJson,
    );
    if (response.data['code'] == '200') {
      return response;
    }
    if (response.data['code'] == '1707') {
      var headers1 = await getHeader2();
      final response1 = await dio.put(
        '$url$urlChecker',
        options: Options(headers: headers1),
        data: modifytJson,
      );
      if (response1.data['code'] == '200'){
        storage.write(key: "authorization", value: '${response1.headers['authorization']?.first}');
        storage.write(key: "authorization-refresh", value: '${response1.headers['authorization-refresh']}');
      }
      return response1;
    }
  }
  deleteApi (String urlChecker) async{
    var headers = await getHeader();
    final response = await dio.delete(
      '$url$urlChecker',
      options: Options(headers: headers),
    );
    if (response.data['code'] == '200') {
      return response;
    }
    if (response.data['code'] == '1707') {
      var headers1 = await getHeader2();
      final response1 = await dio.delete(
        '$url$urlChecker',
        options: Options(headers: headers1),
      );
      if (response1.data['code'] == '200'){
        storage.write(key: "authorization", value: '${response1.headers['authorization']?.first}');
        storage.write(key: "authorization-refresh", value: '${response1.headers['authorization-refresh']}');
      }
      return response1;
    }
  }
  patchApi1 (String urlChecker) async{
    var headers = await getHeader();
    final response = await dio.patch(
      '$url$urlChecker',
      options: Options(headers: headers),
    );
    if (response.data['code'] == '200') {
      return response;
    }
    if (response.data['code'] == '1707') {
      var headers1 = await getHeader2();
      final response1 = await dio.patch(
        '$url$urlChecker',
        options: Options(headers: headers1),
      );
      if (response1.data['code'] == '200'){
        storage.write(key: "authorization", value: '${response1.headers['authorization']?.first}');
        storage.write(key: "authorization-refresh", value: '${response1.headers['authorization-refresh']}');
      }
      return response1;
    }
  }
  patchApi2 (String urlChecker, modifytJson) async{
    var headers = await getHeader();
    final response = await dio.patch(
      '$url$urlChecker',
      data: modifytJson,
      options: Options(headers: headers),
    );
    if (response.data['code'] == '200') {
      return response;
    }
    if (response.data['code'] == '1707') {
      var headers1 = await getHeader2();
      final response1 = await dio.patch(
        '$url$urlChecker',
        data: modifytJson,
        options: Options(headers: headers1),
      );
      if (response1.data['code'] == '200'){
        storage.write(key: "authorization", value: '${response1.headers['authorization']?.first}');
        storage.write(key: "authorization-refresh", value: '${response1.headers['authorization-refresh']}');
      }
      return response1;
    }
  }
  Future<Map<String, dynamic>?> getHeader() async {
    dynamic authorization = await storage.read(key:'authorization');
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authorization}",
    };
    return headers;
  }
  Future<Map<String, dynamic>?> getHeader2() async {
    dynamic authorization = await storage.read(key:'authorization-refresh');
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authorization}",
    };
    return headers;
  }
}

