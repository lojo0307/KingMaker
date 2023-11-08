import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kingmaker/api/social_api.dart';

class SocialRepository {
  final SocialApi _socialApi = SocialApi();

  Future<String?> kakaologin() {
    return _socialApi.kakaologin();
  }
  Future<String> googlelogin() {
    return _socialApi.googlelogin();
  }
}