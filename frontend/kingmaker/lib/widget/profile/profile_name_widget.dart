import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class ProfileNameWidget extends StatefulWidget {
  const ProfileNameWidget({super.key});

  @override
  State<ProfileNameWidget> createState() => _ProfileNameWidgetState();
}

class _ProfileNameWidgetState extends State<ProfileNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage('assets/user_level/level.png')),
        Text(
          Provider.of<MemberProvider>(context, listen: false).member!.nickname,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
        ),
        const Icon(CupertinoIcons.gear_alt_fill,color: Colors.grey,),
      ],
    );
  }
}
