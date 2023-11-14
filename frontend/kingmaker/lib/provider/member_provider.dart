import 'package:flutter/material.dart';
import 'package:kingmaker/api/fcm_api.dart';
import 'package:kingmaker/dto/member_dto.dart';
import 'package:kingmaker/repository/fcm_repository.dart';
import 'package:kingmaker/repository/member_repository.dart';
import 'package:kingmaker/repository/social_repository.dart';

class MemberProvider with ChangeNotifier {
  late final MemberRepository _memberRepository;
  late final SocialRepository _socialRepository;
  late final FcmRepository _fcmRepository;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  MemberDto? _member;
  MemberDto? get member => _member;

  String _errorMessage = " ";
  String get errorMessage => _errorMessage;

  String? _token = "";
  String? get token => _token;

  String? _social = "";
  String? get social => _social;

  MemberProvider() {
    _memberRepository = MemberRepository();
    _socialRepository = SocialRepository();
    _fcmRepository=FcmRepository();
    checkToken();
  }
  void setNickName(String name){
    if (name.length > 10)
      _errorMessage = "존함은 10자 이하로 지어주십시오.";
    else if (name.isEmpty)
      _errorMessage = "존함을 작성 하셔야 합니다.";
    else {
      _member?.nickname = name;
      _errorMessage = " ";
    }
  }

  void initializeNoficiationSetting(){
    _fcmRepository.initializeNotification();
  }

  void registFcmToken(){
    int? memberId =  _member?.memberId;
    _fcmRepository.registFcmToken(memberId!);
  }

  void deleteDeviceFcmToken(){
    //재발급 등의 이유로 기기의 FCM 토큰을 삭제할 때 사용
    //백 DB에서 삭제하려면, deleteFcmTokenFromDB 사용하세요
    _fcmRepository.deleteDevicecFcmToken();
  }

  void deleteFcmTokenFromDB(){
    _fcmRepository.deleteFcmTokenFromDB();
  }

  void modifyNickName(String name){
    int? memberId =  _member?.memberId;
    _memberRepository.modifyNick(memberId!, name);

  }

  void checkToken() async {
    _isLoggedIn = (await _memberRepository.checkFreshToken());
  }

  Future<int> GoogleLogin() async {
    _social = "G";
    _token = await _socialRepository.googlelogin();
    if(token == null){
      //로그인 실패
      return -1;
    }
    _member = await _memberRepository.checkMemberGoogle(token!);
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
    _social = "K";
    _token = await _socialRepository.kakaologin();
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

  getMember() async {
    if (_social == "G") {
      _member = await _memberRepository.checkMemberGoogle(token!);
    } else {
      _member = await _memberRepository.checkMemberKakao(token!);
    }
  }
}