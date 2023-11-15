class RewardDto{
  int rewardId;
  String rewardNm;
  String rewardCond;
  String rewardMsg;
  String modifiedAt;
  int rewardPercent;
  bool achieved;

  RewardDto({
    required this.rewardId,
    required this.rewardNm,
    required this.rewardCond,
    required this.rewardMsg,
    required this.modifiedAt,
    required this.rewardPercent,
    required this.achieved,
  });
  factory RewardDto.fromJson(Map<String, dynamic> json) {
    return RewardDto(
      rewardId: json['rewardId'],
      rewardNm: json['rewardNm'],
      rewardCond: json['rewardCond'],
      rewardMsg: json['rewardMsg'],
      modifiedAt: json['modifiedAt'],
      rewardPercent: json['rewardPercent'],
      achieved: json['achieved'],
    );
  }
}