import 'package:kingmaker/api/kingdom_api.dart';

class KingdomRepository {
  final KingdomApi _kingdomApi = KingdomApi();

  getKingdom(int memberId) {
    return _kingdomApi.getKingdom(memberId);
  }
}