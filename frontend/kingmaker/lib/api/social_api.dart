
import 'package:google_sign_in/google_sign_in.dart';

class SocialApi{
  Future<String> kakaologin() async {
    String token = "";
    // 인가코드

    return token;
  }
  Future<String> googlelogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      // 서버의 client ID를 사용하고 offline access를 활성화해야 함
      scopes: [
        'email',
        // 필요한 추가 스코프를 여기에 추가할 수 있음
      ],

    );
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;
      print('accessToken : ${googleSignInAuthentication.accessToken}');
      // 인증 코드가 있는지 확인하고, 없다면 사용자에게 필요한 권한을 요청함
      if (googleUser == null) {
        // 사용자가 로그인을 취소한 경우
        return 'User cancelled the login process';
      } else {
        // serverAuthCode가 null인 경우 사용자에게 다시 권한을 요청해야 함
        if (googleSignInAuthentication == null) {
          // 사용자가 필요한 권한을 부여하지 않았을 때의 처리
          await googleSignIn.signOut();
          return 'Required consent not granted by user';
        } else {
          // 성공적으로 인증 코드를 받음
          // String! accessToken = (googleSignInAuthentication.accessToken)as String;
          // 여기에 백엔드 서버로 serverAuthCode를 보내는 로직 추가
          return googleSignInAuthentication.accessToken!;
        }
      }
    } catch (error) {
      // 오류 처리
      print('Error while signing in with Google: $error');
      return 'Failed to sign in with Google';
    }
  }
}

