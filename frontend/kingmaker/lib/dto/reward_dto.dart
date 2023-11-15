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
      modifiedAt: json['modifiedAt'] ?? "",
      rewardMsg: json['rewardMsg'] ?? "",
      rewardPercent: json['rewardPercent'] ?? 0,
      achieved: json['achieved'] ?? true,
    );
  }
}