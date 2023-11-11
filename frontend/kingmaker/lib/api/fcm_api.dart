import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmApi{

  //TODO: 첫 로그인 시 권한 요청하고 토큰 발급하는 함수-권한 수락했을 때에만 토큰 서버에 전송하도록...
  Future<String?> generateFcmToken() async{
    //알림 허용
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    
    //TODO: 권한 체크하고 토큰 발급
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    //   provisional: false,
    // );
    //
    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   return getFcmToken();
    // }
    // else{
    //   print("권한 요청이 거절됨");
    //   return null;
    // }

    return getFcmToken();
  }

  //TODO: 앱 로그인 시 fcmToken 갱신하는 함수
  Future<String?> getFcmToken() async {
    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    return _fcmToken;
  }

  //TODO: 토큰 재발급 등의 이슈로 기기의 토큰을 삭제해야 할 때
  void deleteFcmToken(){
    FirebaseMessaging.instance.deleteToken();
    return;
  }

  //TODO: 알림 초기 설정
  void initializeNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final FirebaseMessaging messaging=FirebaseMessaging.instance;

    //이 앱에서 보내는 알림이 높은 중요도를 가지도록, android의 알림 채널을 커스텀
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(const AndroidNotificationChannel(
        'high_importance_channel',
        'high_importance_notification',
        importance: Importance.max));

    //foreground 권한 요청
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //background 권한 요청
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  
    //앱 시작 시점에 initialize하는 함수
    // await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    //   android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    // ));
  }

  //TODO: 메시지 수신 시 처리하는 함수
}