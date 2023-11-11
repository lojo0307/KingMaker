import 'package:flutter/material.dart';
class SignupText extends StatelessWidget {
  const SignupText({super.key,required  this.line1,required  this.line2});
  final line1;
  final line2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(line1,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(line2,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
