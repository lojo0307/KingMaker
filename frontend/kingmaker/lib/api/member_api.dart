
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kingmaker/api/total_api.dart';
import 'dart:math';

import 'package:kingmaker/dto/member_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class MemberApi{
  final storage = const FlutterSecureStorage();
  final TotalApi totalApi = TotalApi();
  Future<bool> checkToken() async{
    bool res = true;
    int number = Random().nextInt(100);
    if (number < 50)
      res = true;
    else
      res = false;
    return false;
  }
  Future<MemberDto?> checkGoogleToken(String code) async{
    MemberDto? res = null;
    // int number = Random().nextInt(100);
    try{
      final response = await dio.get(
        '$url/api/auth/google?code=${code}',
      );
      print(response.headers);
      print('Headers:');
      response.headers.forEach((k, v) => print('$k: $v'));
      storage.write(key: "authorization", value: '${response.headers['authorization']?.first}');
      storage.write(key: "authorization-refresh", value: '${response.headers['authorization-refresh']}');
      print('checkGoogleToken - response: ${response.data['data']}');
      res = MemberDto.responseFromJson(response.data['data']);
      return res;
    }catch (e) {
      print(e);
      return null;
    }
  }

  Future<MemberDto?> checkKakaoToken(String token) async{
    MemberDto? res;
    try{
      final response = await dio.get(
        '$url/api/auth/kakao?code=$token',
      );
      response.headers.forEach((k, v) => print('$k: $v'));
      storage.write(key: "authorization", value: '${response.headers['authorization']?.first}');
      storage.write(key: "authorization-refresh", value: '${response.headers['authorization-refresh']}');
      return MemberDto.responseFromJson(response.data['data']);
    } catch(e) {
      print(e);
    }

    return res;
  }

  void signup(MemberDto? _member, String kdName) async{
    //회원가입 하는 부분 back 연동 해야됨
    print('signup :  ${_member} /kdName : ${kdName}');
    try {
      var data = {
        "nickname": _member?.nickname,
        "kingdomName": kdName,
        "gender": _member?.gender
      };
      print('dio를 사용하여 요청을 보냅니다.');
      final response = await totalApi.postApi(
        '/api/member/signup', data,
      );
      // 응답으로부터 MemberDto 객체를 생성합니다.
      _member = MemberDto.responseFromJson(response.data['data']);
    }catch (e) {
      print(e);
      return null;
    }
  }

  void modifyNickname(int memberId, String nickname) async{
    final response = await dio.patch(
      '$url/api/mypage/nickname',
      data: {
        "memberId" : memberId,
        "nickname" : nickname
      }
    );
  }
}

