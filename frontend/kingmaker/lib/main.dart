import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/page/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/provider/alarm_provider.dart';
import 'package:kingmaker/provider/calendar_provider.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:kingmaker/provider/test_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api/fcm_api.dart';
import 'firebase_options.dart';

//background 상태에서 메시지를 수신할 수 있게 하는 핸들러
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 로컬 알림을 표시하는 로직
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
    0, // 알림 ID
    message.notification?.title, // 알림 제목
    message.notification?.body, // 알림 내용
    notificationDetails,
  );
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );
  KakaoSdk.init(
    nativeAppKey: dotenv.env['NATIVE_APP_KEY'],
  );

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AlarmProvider>(
          create: (context) => AlarmProvider(),
        ),
        ChangeNotifierProvider<AchievementProvider>(
          create: (context) => AchievementProvider(),
        ),
        ChangeNotifierProvider<CalendarProvider>(
          create: (context) => CalendarProvider(),
        ),
        ChangeNotifierProvider<RegistProvider>(
          create: (context) => RegistProvider(),
        ),
        ChangeNotifierProvider<ScheduleProvider>(
          create: (context) => ScheduleProvider(),
        ),
        ChangeNotifierProvider<MemberProvider>(
          create: (context) => MemberProvider(),
        ),
        ChangeNotifierProvider<KingdomProvider>(
          create: (context) => KingdomProvider(),
        ),
        ChangeNotifierProvider<TestProvider>(
          create: (context) => TestProvider(),
        )
      ],
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kingMaker',
      theme: ThemeData(
        fontFamily: 'PretendardBold',
        useMaterial3: true,
      ),
      home: Consumer<MemberProvider>(
            builder: (context, provider, child) {
            var isLoggedIn = provider.isLoggedIn;
              return Container(
                color: LIGHTEST_BLUE_COLOR,
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: isLoggedIn? const BottomNavBar() : const LoginPage(),
                // child: TestPage(),
              );
            },
          ),
    );
  }
}