import 'package:flutter/material.dart';
import 'package:kingmaker/page/test_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  runApp(const MyApp());
  await dotenv.load(fileName: ".env");
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
      home: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        // child: isLoggedIn? const BottomNavBar() : const LoginPage(),
        child: TestPage(),
      ),
    );
  }
}