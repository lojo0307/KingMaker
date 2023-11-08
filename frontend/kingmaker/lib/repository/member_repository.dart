import 'package:kingmaker/api/member_api.dart';
import 'package:kingmaker/dto/member_dto.dart';

class MemberRepository {
  final MemberApi _memberApi = MemberApi();

  Future<bool> checkFreshToken() {
    return _memberApi.checkToken();
  }

  Future<MemberDto?> checkMemberGoogle(String token) {
    return _memberApi.checkGoogleToken(token);
  }

  Future<MemberDto?> checkMemberKakao(String token) {
    return _memberApi.checkKakaoToken(token);
  }

  signup(MemberDto? member, String kdName) {
    _memberApi.signup(member, kdName);
  }
}