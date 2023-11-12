class RewardDto{
  String rewardNm;
  String rewardCond;
  String modifiedAt;
  int rewardPercent;
  bool achieved;

  RewardDto({
    required this.rewardNm,
    required this.rewardCond,
    required this.modifiedAt,
    required this.rewardPercent,
    required this.achieved,
  });
  factory RewardDto.fromJson(Map<String, dynamic> json) {
    return RewardDto(
      rewardNm: json['rewardNm'],
      rewardCond: json['rewardCond'],
      modifiedAt: json['modifiedAt'],
      rewardPercent: json['rewardPercent'],
      achieved: json['achieved'],
    );
  }
}