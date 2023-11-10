class MemberDto{
  int memberId;
  int credentialId;
  int kingdomId;
  String nickname;
  String gender;
  String email;
  String provider;
  MemberDto({
    required this.memberId,
    required this.credentialId,
    required this.kingdomId,
    required this.nickname,
    required this.gender,
    required this.email,
    required this.provider
  });
  factory MemberDto.fromJson(Map<String, dynamic> json) {
    return MemberDto(
      memberId: int.parse(json['memberId']),
      credentialId: json['credentialId'],
      kingdomId: json['kingdomId'],
      nickname: json['nickname'],
      gender: json['gender'],
      email: json['email'],
      provider: json['provider']
    );
  }
  factory MemberDto.responseFromJson(Map<String, dynamic> json) {
    return MemberDto(
      memberId: json['memberId'],
      credentialId: 0,
      kingdomId: 0,
      nickname: json['nickname'] ?? "",
      gender: json['gender'] ?? "MAN",
      email: json['email'] ?? "",
      provider: json['provider'] ?? "",
    );
  }
  String toString(){
    return "memberID:${memberId}, credentialId: ${credentialId},"
        " kingdomId: ${kingdomId}, nickname: ${nickname}, gender:${gender}, email:${email}, provider:${provider}";
  }

  toModifytJson() {
    return {
      "memberId" : memberId,
      "credentialId" : credentialId,
      "kingdomId" : kingdomId,
      "nickname" : nickname,
      "gender" : gender,
    };
  }
}