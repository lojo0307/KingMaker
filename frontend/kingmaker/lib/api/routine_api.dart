
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kingmaker/dto/member_routine_dto.dart';
import 'package:kingmaker/dto/routine_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class RoutineApi{
  final storage = const FlutterSecureStorage();
  Future <List<MemberRoutineDto>> getData(int memberId, String date) async{
    dynamic authorization =await storage.read(key:'authorization');
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authorization}",
    };
    print('RoutineApi-- date: ${date}, memberId: ${memberId}');
    try{
      final response = await dio.get(
        '$url/api/routine/$memberId?date=$date',
        options: Options(headers: headers),
      );
      print('RoutineApi-- getData: ${response}');
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

  void modifyRoutine(RoutineDto routine) async {
    final response = await dio.put(
      '$url/api/routine',
      data: routine.toModifyJson(),
    );
  }

  void deleteRoutine(int routineId) async {
    final response = await dio.delete(
      '$url/api/routine/$routineId',
    );
  }

  void acheiveRoutine(int memberRoutineId) async {
    final response = await dio.patch(
      '$url/api/routine/$memberRoutineId',
    );
  }

  Future <MemberRoutineDto> getDetailRoutine(int memberRoutineId) async {
    try{
      final response = await dio.get(
        '$url/api/routine/detail/$memberRoutineId',
      );
      return MemberRoutineDto.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return {} as MemberRoutineDto;
    }
  }
}

