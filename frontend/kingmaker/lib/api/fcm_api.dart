import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class FcmApi{
  Future<String?> generateFcmToken() async{
    //알림 허용
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return getFcmToken();
    }
    else{
      print("권한 요청이 거절됨");
      return null;
    }
  }

  Future<String?> getFcmToken() async {
    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    return _fcmToken;
  }

  void deleteFcmToken(){
    FirebaseMessaging.instance.deleteToken();
    return;
  }
  
  //TODO: 메시지 수신 시 처리하는 함수
}