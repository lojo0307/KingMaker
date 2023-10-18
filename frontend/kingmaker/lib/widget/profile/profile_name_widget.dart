import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileNameWidget extends StatefulWidget {
  const ProfileNameWidget({super.key});

  @override
  State<ProfileNameWidget> createState() => _ProfileNameWidgetState();
}

class _ProfileNameWidgetState extends State<ProfileNameWidget> {
  String name = "리히트";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage('assets/user_level/level.png')),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
        ),
        const Icon(CupertinoIcons.gear_alt_fill,color: Colors.grey,),
      ],
    );
  }
}

