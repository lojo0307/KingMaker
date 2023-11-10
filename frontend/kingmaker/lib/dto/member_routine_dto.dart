import 'package:kingmaker/dto/routine_dto.dart';

class MemberRoutineDto{
  int memberRoutineId;
  RoutineDto routine;
  bool achievedYn;


  MemberRoutineDto({
    required this.memberRoutineId,
    required this.routine,
    required this.achievedYn,

  });

  factory MemberRoutineDto.fromJson(Map<String, dynamic> json) {
    return MemberRoutineDto(
        memberRoutineId: json['memberRoutineId'],
        routine: RoutineDto.fromJson(json['routine']),
        achievedYn: json['achievedYn']==1? true : false);

  }
}