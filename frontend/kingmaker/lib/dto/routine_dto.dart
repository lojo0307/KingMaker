class RoutineDto{
  int routineId;
  int categoryId;
  String routineNm;
  String routineDetail;
  String period;
  bool importantYn;
  String startAt;
  String endAt;

  RoutineDto({
    required this.routineId,
    required this.categoryId,
    required this.routineNm,
    required this.routineDetail,
    required this.period,
    required this.importantYn,
    required this.startAt,
    required this.endAt,
  });

  factory RoutineDto.fromJson(Map<String, dynamic> json) {
    print('111111111111111111111111111');
    print(json['startAt']);
    print('22222222222222222222222222222');
    return RoutineDto(
      routineId: json['routineId'],
      categoryId: json['categoryId'],
      routineNm: json['routineNm'],
      routineDetail: json['routineDetail'],
      period: json['period'],
      importantYn: json['importantYn'],
      startAt: json['startAt'],
      endAt: json['endAt'],
    );
  }
  Map<String, dynamic> toRegistJson(int memberId) {
    return {
      "memberId" : memberId,
      "categoryId" : categoryId,
      "period" : period,
      "routineNm" : routineNm,
      "importantYn" : importantYn,
      "routineDetail" : routineDetail,
      "startAt" : startAt,
      "endAt" : endAt,
    };
  }
  String toString(){
    return " $routineId, $categoryId, $routineNm, $routineDetail, $period, $importantYn, $startAt, $endAt,";
  }
}