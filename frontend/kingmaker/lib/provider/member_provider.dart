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
    String token = await _socialRepository.googlelogin();
    _member = await _memberRepository.checkMemberGoogle(token);
    if (member == null){
      _member = new MemberDto(memberId: 0, credentialId: 0, kingdomId: 0, nickname: "", gender: "M");
      return 0;
    }
    else
      return 1;
  }

  Future<int> KakaoLogin() async{
    String token = await _socialRepository.kakaologin();
    _member = await _memberRepository.checkMemberKakao(token);
    if (member == null) {
      _member = new MemberDto(memberId: 0, credentialId: 0, kingdomId: 0, nickname: "", gender: "M");
      return 0;
    } else
      return 1;
  }

  void changeGender() {
    _member?.gender = _member?.gender == "W" ? "M" : "W";
  }

  void setErrorFirst() {
    _errorMessage = " ";
  }

  void signup() async{
    await _memberRepository.signup(_member);
  }
}