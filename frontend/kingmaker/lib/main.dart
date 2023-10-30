import 'package:flutter/material.dart';
import 'package:kingmaker/page/test_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kingmaker/provider/test_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
const isLoggedIn = false;

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
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider<TestProvider>(
              create: (context) => TestProvider(),
            )
          ],
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            // child: isLoggedIn? const BottomNavBar() : const LoginPage(),
            child: TestPage(),
          ),
      ),
    );
  }
}