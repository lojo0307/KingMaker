import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class SocialApi{
  final storage = const FlutterSecureStorage();
  Future<String?> kakaologin() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) { // 카톡이 있는 경우
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          return token.accessToken;
        } catch (e) {
          return null;
        }
      } else { // 카톡이 없는 경우
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          return token.accessToken;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> googlelogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;
      // 인증 코드가 있는지 확인하고, 없다면 사용자에게 필요한 권한을 요청함
      if (googleUser == null) {
        // 사용자가 로그인을 취소한 경우
        return null;
      } else {
        // serverAuthCode가 null인 경우 사용자에게 다시 권한을 요청해야 함
        if (googleSignInAuthentication == null) {
          // 사용자가 필요한 권한을 부여하지 않았을 때의 처리
          await googleSignIn.signOut();
          return null;
        } else {
          //accessToken을 저장
          return googleSignInAuthentication.accessToken;
        }
      }
    } catch (error) {
      // 오류 처리
      return null;
    }
  }
}

