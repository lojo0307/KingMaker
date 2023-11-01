class RoutineDto{
  int routineId;
  int categoryId;
  String category;
  String routineNm;
  String routineDetail;
  String period;
  bool importantYn;
  String startAt;
  String endAt;

  RoutineDto({
    required this.routineId,
    required this.categoryId,
    required this.category,
    required this.routineNm,
    required this.routineDetail,
    required this.period,
    required this.importantYn,
    required this.startAt,
    required this.endAt,
  });

  factory RoutineDto.fromJson(Map<String, dynamic> json) {
    return RoutineDto(
      routineId: int.parse(json['routineId']),
      categoryId: json['category']['categoryId'],
      category: json['category']['categoryNm'],
      routineNm: json['routineNm'],
      routineDetail: json['routineDetail'],
      period: json['period'],
      importantYn: json['importantYn'],
      startAt: json['startAt'],
      endAt: json['endAt'],
    );
  }
}