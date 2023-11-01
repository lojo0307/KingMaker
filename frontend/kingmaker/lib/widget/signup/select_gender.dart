import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTap: () {
              provider.changeGender();
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              height: 150,
              width: 150,
              child: Image(
                image: (provider.member?.gender == "W")? AssetImage('assets/character/charWoman.png') : AssetImage('assets/character/charMan.png'),
              ),
            ),
          );
        });
  }
}
