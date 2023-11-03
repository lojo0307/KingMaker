import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/routine_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class RoutineApi{
  Future <List<MemberRoutineDto>> getData(int memberId, String date) async{
    try{
      print('routine1');
      final response = await dio.get(
        '$url/api/routine/$memberId?date=$date',
      );
      print('routine2');
      return response.data['data']['dailyRoutines'].map<MemberRoutineDto>((memberRoutine) {
        return MemberRoutineDto.fromJson(memberRoutine);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }

  void registRoutine(int memberId, RoutineDto routine) async {
    final response = await dio.post(
      '$url/api/routine',
      data: routine.toRegistJson(memberId),
    );
  }
}

