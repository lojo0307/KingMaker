import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

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
          child: Image(
            image: (Provider.of<MemberProvider>(context, listen: false).member?.gender == "W") ? AssetImage('assets/character/charWoman.png'): AssetImage('assets/character/charMan.png'),
          ),
        )],
    );
  }
}
