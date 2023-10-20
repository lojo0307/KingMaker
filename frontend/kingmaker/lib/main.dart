import 'package:flutter/material.dart';
import 'package:kingmaker/page/login_page.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}
const isLoggedIn = false;
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kingMaker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: isLoggedIn? const BottomNavBar() : const LoginPage(),
      ),
    );
  }
}