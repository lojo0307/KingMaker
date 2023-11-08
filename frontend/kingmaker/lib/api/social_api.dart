import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
class SocialApi{
  Future<String?> kakaologin() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) { // 카톡이 있는 경우
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print(token.accessToken);
          return token.accessToken;
        } catch (e) {
          return null;
        }
      } else { // 카톡이 없는 경우
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print(token.accessToken);
          return token.accessToken;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }
  Future<String> googlelogin() async {
    String token = "";
    return token;
  }
}

