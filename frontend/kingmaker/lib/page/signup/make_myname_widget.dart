import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/signup/gender_img.dart';
import 'package:kingmaker/widget/signup/next_button.dart';
import 'package:kingmaker/widget/signup/select_gender.dart';
import 'package:kingmaker/widget/signup/signup_text.dart';
import 'package:kingmaker/widget/signup/signup_write_name.dart';
import 'package:provider/provider.dart';

class MakeMynamePage extends StatefulWidget {
  const MakeMynamePage({super.key});

  @override
  State<MakeMynamePage> createState() => _MakeMynamePageState();
}

class _MakeMynamePageState extends State<MakeMynamePage> {
  @override
  Widget build(BuildContext context) {
    print('makepage');
    print(context.read<MemberProvider>());
    return SafeArea(
      child: const Scaffold(
        backgroundColor: Color(0xFFEDF1FF),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              SelectGender(),
              SignupText(line1: 'Your majesty,', line2: '당신의 존함을 알려주십시오.',),
              SignupWriteName(),

              NextButton(),
            ],
          ),
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
