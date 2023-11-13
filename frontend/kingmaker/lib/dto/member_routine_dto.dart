import 'package:kingmaker/dto/routine_dto.dart';

class MemberRoutineDto{
  int memberRoutineId;
  RoutineDto routine;
  bool achievedYn;
  bool importantYn;

  MemberRoutineDto({
    required this.memberRoutineId,
    required this.routine,
    required this.achievedYn,
    required this.importantYn,
  });

  factory MemberRoutineDto.fromJson(Map<String, dynamic> json) {
    return MemberRoutineDto(
        memberRoutineId: json['memberRoutineId'],
        routine: RoutineDto.fromJson(json['routine']),
        achievedYn: json['achievedYn']==1? true : false,
        importantYn: json['importantYn']==1?true: false

    );


  }
}