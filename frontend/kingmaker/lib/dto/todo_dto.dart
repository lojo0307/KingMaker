class TodoDto{
  int todoId;
  int categoryId;
  String startAt;
  String endAt;
  String todoNm;
  String todoDetail;
  String todoPlace;
  bool importantYn;
  bool achievedYn;

  String toString(){
    return '$todoId,$categoryId,$startAt,$endAt,$todoNm,$todoDetail,$todoPlace,$importantYn,$achievedYn';
  }
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
  factory TodoDto.fromJson(int todoId, Map<String, dynamic> json) {
    return TodoDto(
      todoId: todoId,
      categoryId: json['categoryId'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      todoNm: json['todoNm'],
      todoDetail: json['todoDetail'],
      todoPlace: json['todoPlace'],
      importantYn: (json['importantYn'] == 1) ? true : false,
      achievedYn: (json['achievedYn'] == 1) ? true : false,
    );
  }
  factory TodoDto.fromJsonToListDto(Map<String, dynamic> json) {
    return TodoDto(
      todoId: json['todoId'],
      categoryId: json['categoryId'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      todoNm: json['todoNm'],
      todoDetail: "",
      todoPlace: "",
      importantYn: (json['importantYn'] == 1) ? true : false,
      achievedYn: (json['age'] == 1) ? true : false,
    );
  }

  toRegistJson(int memberId) {
    return {
      "memberId": memberId,
      "categoryId": categoryId,
      "startAt": startAt,
      "endAt": endAt,
      "todoNm": todoNm,
      "todoDetail": todoDetail,
      "todoPlace": todoPlace,
      "importantYn": importantYn,
      "monsterCd": 1
    };
  }

  toModifytJson() {
    return {
      "todoId": todoId,
      "categoryId": categoryId,
      "startAt": startAt,
      "endAt": endAt,
      "todoNm": todoNm,
      "todoDetail": todoDetail,
      "todoPlace": todoPlace,
      "importantYn": importantYn,
      "monsterCd": 1
    };
  }
}
