import 'package:flutter/material.dart';

class ProfileCharImageWidget extends StatefulWidget {
  const ProfileCharImageWidget({super.key});

  @override
  State<ProfileCharImageWidget> createState() => _ProfileCharImageWidgetState();
}

class _ProfileCharImageWidgetState extends State<ProfileCharImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          height: 150,
          width: 150,
          child: const Image(
            image: AssetImage('assets/character/charMan.png'),
          ),
        )],
    );
  }
}
