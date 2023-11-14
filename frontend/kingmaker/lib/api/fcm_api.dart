import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kingmaker/api/total_api.dart';
import 'package:kingmaker/dto/fcm_dto.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();

class FcmApi{
  final TotalApi totalApi = TotalApi();
  //TODO: 앱 로그인 시 fcmToken 갱신하는 함수
  void registFcmToken(int memberId) async {
    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    FcmDto fcmDto=FcmDto(memberId: memberId, token: _fcmToken!);
    final response = await totalApi.postApi('/api/member/fcmtoken',fcmDto.toRegistJson());
    return;
  }

  //TODO: 토큰 재발급 등의 이슈로 "기기의" 토큰을 삭제해야 할 때
  void deleteDeviceFcmToken(){
    FirebaseMessaging.instance.deleteToken();
    return;
  }
  
  void deleteFcmTokenFromDB() async{
    String? _fcmToken = await FirebaseMessaging.instance.getToken();
    final response=await totalApi.deleteApi('api/member/fcmtoken?token=$_fcmToken');
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
    // foreground 메시지 수신 시-이벤트 리스너
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
      }
    });

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
  }
}