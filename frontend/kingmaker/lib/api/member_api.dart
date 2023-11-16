import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kingmaker/api/total_api.dart';
import 'dart:math';
import 'package:kingmaker/dto/member_dto.dart';
import 'package:kingmaker/dto/reward_dto.dart';
import 'package:kingmaker/widget/achievement/test_modal.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class MemberApi{
  final storage = const FlutterSecureStorage();
  final TotalApi totalApi = TotalApi();
  final TestModal testModal = TestModal();

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
      storage.write(key: "authorization", value: '${response.headers['authorization']?.first}');
      storage.write(key: "authorization-refresh", value: '${response.headers['authorization-refresh']}');
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
      storage.write(key: "authorization", value: '${response.headers['authorization']?.first}');
      storage.write(key: "authorization-refresh", value: '${response.headers['authorization-refresh']}');
      return MemberDto.responseFromJson(response.data['data']);
    } catch(e) {
      print(e);
    }
    return res;
  }

  Future<MemberDto?> signup(MemberDto? _member, String kdName) async{
    //회원가입 하는 부분 back 연동 해야됨
    MemberDto? res;
    try {
      var data = {
        "nickname": _member?.nickname,
        "kingdomName": kdName,
        "gender": _member?.gender
      };
      final response = await totalApi.postApi(
        '/api/member/signup', data,
      );
      // 응답으로부터 MemberDto 객체를 생성합니다.
      _member = MemberDto.responseFromJson(response.data['data']);
      if (response.data['data']['rewardResDto'] != null){
        testModal.getViewModel(
            RewardDto.fromJson(response.data['data']['rewardResDto']['rewardInfoDto'])
        );
      }
      return MemberDto.fromJson(response.data['data']);
    }catch (e) {
      print(e);
    }
    return res;
  }

  Future<bool> modifyNickname(int memberId, String nickname) async{
    final response = await totalApi.patchApi2(
      '/api/mypage/nickname',
      {
        "memberId" : memberId,
        "nickname" : nickname
      }
    );
    if(response.statusCode=='200'){
      return true;
    }
    print(response.statusCode);
    return false;
  }

  void delteMember() async {
    final response = await totalApi.deleteApi('/api/member/leave');
  }
}

