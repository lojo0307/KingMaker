import 'package:kingmaker/dto/routine_dto.dart';

class MemberRoutineDto{
  int memberRoutineId;
  RoutineDto routine;
  bool achievedYn;
  int monsterCd;

  MemberRoutineDto({
    required this.memberRoutineId,
    required this.routine,
    required this.achievedYn,
    required this.monsterCd,
  });
  factory MemberRoutineDto.fromJson(Map<String, dynamic> json) {
    print(json['memberRoutineId']);
    print(json['routine']);
    print(json['achievedYn']);
    print(json['monsterCd']);
    return MemberRoutineDto(
        memberRoutineId: json['memberRoutineId'],
        routine: RoutineDto.fromJson(json['routine']),
        achievedYn: json['achievedYn'],
        monsterCd: json['monsterCd']);
  }
}