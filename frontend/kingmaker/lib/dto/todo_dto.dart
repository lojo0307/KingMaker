class TodoDto{
  int todoId;
  int categoryId;
  String startAt;
  String endAt;
  String todoNm;
  String todoDetail;
  String todoPlace;
  int importantYn;
  int achievedYn;

  TodoDto({
    required this.todoId,
    required this.categoryId,
    required this.startAt,
    required this.endAt,
    required this.todoNm,
    required this.todoDetail,
    required this.todoPlace,
    required this.importantYn,
    required this.achievedYn,
  });
  factory TodoDto.fromJson(Map<String, dynamic> json) {
    return TodoDto(
      todoId: json['todoId'],
      categoryId: json['categoryId'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      todoNm: json['todoNm'],
      todoDetail: json['todoDetail'],
      todoPlace: json['todoPlace'],
      importantYn: json['importantYn'],
      achievedYn: json['age'],
    );
  }
}
