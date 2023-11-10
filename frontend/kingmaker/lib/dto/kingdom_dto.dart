class KingdomDto{
  int level;
  String kingdomNm;
  int citizen;

  KingdomDto({
    required this.level,
    required this.kingdomNm,
    required this.citizen,
  });
  factory KingdomDto.fromJson(Map<String, dynamic> json) {
    return KingdomDto(
      level: json['level'],
      kingdomNm: json['kingdomNm'],
      citizen: json['citizen'],
    );
  }
}