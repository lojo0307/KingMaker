import 'package:flutter/material.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class GenderImg extends StatefulWidget {
  const GenderImg({super.key});

  @override
  State<GenderImg> createState() => _GenderImgState();
}

class _GenderImgState extends State<GenderImg> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: 150,
                  width: 150,
                  child: Image(
                    image: (provider.member?.gender == "WOMAN")? AssetImage('assets/character/charWoman.png') : AssetImage('assets/character/charMan.png'),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
