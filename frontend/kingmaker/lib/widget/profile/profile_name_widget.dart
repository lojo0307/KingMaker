import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/profile/profile_update_page.dart';
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
        SizedBox(width: 10,),
        Text(
          Provider.of<MemberProvider>(context, listen: false).member!.nickname,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
        ),
        SizedBox(width: 10,),
        GestureDetector(
          onTap: _showUpdateModal, // Call this method when the icon is tapped
          child: const Icon(CupertinoIcons.gear_alt_fill, color: Colors.grey),
        ),
      ],
    );
  }


  void _showUpdateModal() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileUpdatePage()));
  }
}
