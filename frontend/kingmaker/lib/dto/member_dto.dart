class MemberDto{
  int memberId;
  int credentialId;
  int kingdomId;
  String nickname;
  String gender;

  MemberDto({
    required this.memberId,
    required this.credentialId,
    required this.kingdomId,
    required this.nickname,
    required this.gender,
  });
  factory MemberDto.fromJson(Map<String, dynamic> json) {
    return MemberDto(
      memberId: int.parse(json['memberId']),
      credentialId: json['credentialId'],
      kingdomId: json['kingdomId'],
      nickname: json['nickname'],
      gender: json['gender'],
    );
  }
  String toString(){
    return "$memberId, $credentialId, $kingdomId, $nickname ";
  }
}