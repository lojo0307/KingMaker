import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/widget/signup/next_button.dart';
import 'package:kingmaker/widget/signup/select_gender.dart';
import 'package:kingmaker/widget/signup/signup_text.dart';
import 'package:kingmaker/widget/signup/signup_write_name.dart';

class MakeMynamePage extends StatefulWidget {
  const MakeMynamePage({super.key});

  @override
  State<MakeMynamePage> createState() => _MakeMynamePageState();
}

class _MakeMynamePageState extends State<MakeMynamePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: LIGHTEST_BLUE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80,),
                  SelectGender(),
                  SizedBox(height: 40),
                  SignupText(line1: 'Your majesty,', line2: '당신의 존함을 알려주십시오.',),
                  SizedBox(height: 40,),
                  SignupWriteName(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: NextButton(),
        ),
      );
  }
}
