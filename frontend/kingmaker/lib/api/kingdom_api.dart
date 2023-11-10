import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';

class KingdomApi{
  final TotalApi totalApi = TotalApi();
  void makeKingdom(String kingdomName) async{
    //왕국 만드는 부분 back 연동 해야됨
  }

  getKingdom(int memberId) async {
    try{
      final response = await totalApi.getApi('/api/mypage/kingdom/$memberId',);
      return KingdomDto.fromJson(response.data['data']);
    }catch (e){
      print(e);
      return;
    }

  }
}

