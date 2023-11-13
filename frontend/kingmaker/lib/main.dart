import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/page/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
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

<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788
=======
import 'firebase_options.dart';

>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
//background 상태에서 메시지를 수신할 수 있게 하는 핸들러
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  await dotenv.load(fileName: ".env");
<<<<<<< bd255d85a702689ee2bbe942e61ab82d48f54788
  await Firebase.initializeApp();
=======
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
>>>>>>> e4b3a8d3f8dab1d6d1cbcea9c099f1b19c5340dc
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  KakaoSdk.init(
    nativeAppKey: dotenv.env['NATIVE_APP_KEY'],
  );

  runApp(MultiProvider(
      providers: [
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