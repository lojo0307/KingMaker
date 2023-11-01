import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class RoutineApi{
  Future <List<MemberRoutineDto>> getData(int memberId, String date) async{
    final response = await dio.get(
      '$url//api/routine/${memberId}?date=${date}',
    );
    return response.data['data'].map((memberRoutine) {
      return MemberRoutineDto.fromJson(memberRoutine);
    }).toList();
  }
}

