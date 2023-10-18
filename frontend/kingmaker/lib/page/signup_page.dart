import 'package:flutter/material.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String error = "이름은 10자 이하로 지어주십시오.";
  String name ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF1FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfileCharImageWidget(),
            const Text('Your majesty,',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('당신의 존함을 알려주십시오.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  TextButton(onPressed: () {
                    print(name);
                  }, child: const Text("랜덤 생성")),
                ],
              ),
            ),
            Text(error,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
            TextButton(onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBar()), (route) => false
              );
            }, child: const Text("다음 단계로")),
          ],
        ),
      ),
    );
  }
}