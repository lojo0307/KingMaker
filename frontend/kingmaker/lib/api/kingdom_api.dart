import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class KingdomApi{
  void makeKingdom(String kingdomName) async{
    //왕국 만드는 부분 back 연동 해야됨
  }

  getKingdom(int memberId) async {
      final response = await dio.get(
        '$url/api/mypage/notification/$memberId',
      );
      return KingdomDto.fromJson(response.data['data']);
  }
}

