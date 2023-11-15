import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
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
        SvgPicture.asset('assets/icon/ic_crown.svg'),
        SizedBox(width: 10,),
        Text(
          Provider.of<MemberProvider>(context, listen: false).member!.nickname,
          style: const TextStyle(fontSize: 20, fontFamily: 'EsamanruMedium',),
        ),
        SizedBox(width: 10,),
        GestureDetector(
          onTap: _showUpdateModal, // Call this method when the icon is tapped
          child: SvgPicture.asset('assets/icon/ic_settings.svg', color: DARK_GREY_COLOR, height: 24),
        ),
      ],
    );
  }


  void _showUpdateModal() async {
    final updatedNickname = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileUpdatePage()),
    );

    if (updatedNickname != null) {
      setState(() {
        Provider.of<MemberProvider>(context, listen: false).member!.nickname = updatedNickname;
      });
    }
  }
}
