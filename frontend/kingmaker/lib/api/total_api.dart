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
    return response;
  }
  postApi (String urlChecker, registJson) async{
    var headers = await getHeader();
    return await dio.post(
      '$url$urlChecker',
      data: registJson,
      options: Options(headers: headers),
    );
  }
  putApi (String urlChecker, modifytJson) async{
    var headers = await getHeader();
    return await dio.put(
      '$url$urlChecker',
      options: Options(headers: headers),
        data: modifytJson,
    );
  }
  deleteApi (String urlChecker) async{
    var headers = await getHeader();
    return await dio.delete(
      '$url$urlChecker',
      options: Options(headers: headers),
    );
  }
  patchApi1 (String urlChecker) async{
    var headers = await getHeader();
    return await dio.patch(
      '$url$urlChecker',
      options: Options(headers: headers),
    );
  }
  patchApi2 (String urlChecker, modifytJson) async{
    var headers = await getHeader();
    return await dio.patch(
      '$url$urlChecker',
      data: modifytJson,
      options: Options(headers: headers),
    );
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

