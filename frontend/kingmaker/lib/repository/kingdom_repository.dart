import 'package:kingmaker/api/kingdom_api.dart';

class KingdomRepository {
  final KingdomApi _kingdomApi = KingdomApi();

  void makeKingdom(String kingdomName) {
    _kingdomApi.makeKingdom(kingdomName);
  }

  getKingdom(int memberId) {
    return _kingdomApi.getKingdom(memberId);
  }
}