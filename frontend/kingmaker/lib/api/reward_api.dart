import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/reward_dto.dart';

class RewardApi{
  final TotalApi totalApi = TotalApi();
  Future <List<RewardDto>> getAllReward(int memberId) async{
    try{
      final response = await totalApi.getApi('/api/mypage/reward/$memberId',);
      return response.data['data'].map<RewardDto>((reward) {
        return RewardDto.fromJson(reward);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }
  Future <int> getDailyAchieve(int memberId) async {
    try{
      final response = await totalApi.getApi('/api/mypage/daily/$memberId',);
      return response.data['data'];
    } catch (e) {
      print(e);
      return -1;
    }
  }
  Future <int> getMonthlyAchieve(int memberId) async {
    try{
      final response = await totalApi.getApi('/api/mypage/monthly/$memberId',);
      return response.data['data'];
    } catch (e) {
      print(e);
      return -1;
    }
  }
  Future <int> getyearlyAchieve(int memberId) async {
    try{
      final response = await totalApi.getApi('/api/mypage/yearly/$memberId',);
      return response.data['data'];
    } catch (e) {
      print(e);
      return -1;
    }
  }
  Future <List<String>> getCategory(int memberId) async {
    try{
      final response = await totalApi.getApi('/api/mypage/category/$memberId',);
      String max = response.data['data'].first['categoryId'] == -1 ? "없음" : response.data['data'].first['categoryNm'];
      String min = response.data['data'].last['categoryId'] == -1 ? "없음" : response.data['data'].last['categoryNm'];
      return [max, min];
    } catch (e) {
        print(e);
      return [""];
    }
  }
}

