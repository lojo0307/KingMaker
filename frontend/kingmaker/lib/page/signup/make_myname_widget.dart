import 'package:flutter/material.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';
import 'package:kingmaker/page/signup/make_kingdom_widget.dart';
class MakeMynamePage extends StatefulWidget {
  const MakeMynamePage({super.key});

  @override
  State<MakeMynamePage> createState() => _MakeMynamePageState();
}

class _MakeMynamePageState extends State<MakeMynamePage> {
  int mainColor = 0xFFEDF1FF;
  String error = "이름은 10자 이하로 지어주십시오.";
  String name ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            const ProfileCharImageWidget(),
            const SizedBox(height: 20,),
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
            ElevatedButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MakeKingDomPage())
              );
            }, child: const Text("다음 단계로")),
          ],
        ),
      ),
    );
  }
}
class MyCustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(20, size.height, 20, 40)
      ..quadraticBezierTo(20, 20, 40, 20)
      ..lineTo(size.width - 20, 20)
      ..quadraticBezierTo(size.width, 20, size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
