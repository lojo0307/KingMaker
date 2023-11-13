import 'package:flutter/material.dart';
import 'package:kingmaker/dto/member_dto.dart';
import 'package:kingmaker/repository/member_repository.dart';
import 'package:kingmaker/repository/social_repository.dart';

class MemberProvider with ChangeNotifier {
  late final MemberRepository _memberRepository;
  late final SocialRepository _socialRepository;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  MemberDto? _member;
  MemberDto? get member => _member;

  String _errorMessage = " ";
  String get errorMessage => _errorMessage;
  MemberProvider() {
    _memberRepository = MemberRepository();
    _socialRepository = SocialRepository();
    checkToken();
  }
  void setNickName(String name){
    _member?.nickname = name;
    if (name.length > 10)
      _errorMessage = "존함은 10자 이하로 지어주십시오.";
    else if (name.isEmpty)
      _errorMessage = "존함을 작성 하셔야 합니다.";
    else
      _errorMessage = " ";
  }

  void checkToken() async {
    _isLoggedIn = (await _memberRepository.checkFreshToken());
  }

  Future<int> GoogleLogin() async {
    String? token = await _socialRepository.googlelogin();
    if(token == null){
      //로그인 실패
      return -1;
    }
    _member = await _memberRepository.checkMemberGoogle(token);
    if (member?.memberId == 0){
      //신규 가입
      return 0;
    }
    else {
      //기존 회원
      return member!.memberId;
    }

  }

  Future<int> KakaoLogin() async{
    String? token = await _socialRepository.kakaologin();
    if(token == null) {
      return -1;
    } else {
      _member = await _memberRepository.checkMemberKakao(token!);
      if (_member == null)
        return -1;
      else if (_member?.memberId == 0){
        return 0;
      } else {
        return member!.memberId;
      }
    }
  }

  void changeGender() {
    _member?.gender = _member?.gender == "WOMAN" ? "MAM" : "WOMAN";
  }

  void genderToMale() {
    _member?.gender = "MAN";
  }

  void genderToFemale() {
    _member?.gender = "WOMAN";
  }

  void setErrorFirst() {
    _errorMessage = " ";
  }

  signup(String kdName) async{
    await _memberRepository.signup(_member, kdName);
  }
}