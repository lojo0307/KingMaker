import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class FcmApi{
  Future<String?> generateFcmToken(){
    //알림 허용

    return getFcmToken();
  }

  Future<String?> getFcmToken() async {
    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    return _fcmToken;
  }
}