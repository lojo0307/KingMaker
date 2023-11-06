import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'dart:math';

import 'package:kingmaker/dto/member_dto.dart';
final dio = Dio();
String? url = dotenv.env['URL'];

class MemberApi{
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
    int number = Random().nextInt(100);
    if (number < 50)
      res = new MemberDto(memberId: 1, credentialId: 1, kingdomId: 1, nickname: "123", gender: "M");
    return null;
  }

  Future<MemberDto?> checkKakaoToken(String token) async{
    MemberDto? res = null;
    int number = Random().nextInt(100);
    if (number < 50)
      res = new MemberDto(memberId: 1, credentialId: 1, kingdomId: 1, nickname: "123", gender: "M");
    return res;
  }

  void signup(MemberDto? member) async{
    //회원가입 하는 부분 back 연동 해야됨
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

