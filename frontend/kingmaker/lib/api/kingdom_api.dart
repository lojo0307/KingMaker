import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/kingdom_dto.dart';

class KingdomApi{
  final TotalApi totalApi = TotalApi();
<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788
  void makeKingdom(String kingdomName) async{
    //왕국 만드는 부분 back 연동 해야됨
  }

=======
>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
  getKingdom(int memberId) async {
    try{
      final response = await totalApi.getApi('/api/mypage/kingdom/$memberId',);
      return KingdomDto.fromJson(response.data['data']);
    }catch (e){
      print(e);
      return;
    }
<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788

=======
>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
  }
}

