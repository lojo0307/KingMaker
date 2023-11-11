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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      provider.genderToMale();
                      setState(() {});
                    }, child: Text('남',),
                      style:  ElevatedButton.styleFrom(backgroundColor:  (provider.member?.gender == "WOMAN") ? null : Colors.amberAccent)
                      ),
                    SizedBox(width: 8),
                    ElevatedButton(onPressed: (){
                      provider.genderToFemale();
                      setState(() {});
                    }, child: Text('여'),
                    style:  ElevatedButton.styleFrom(backgroundColor:  (provider.member?.gender == "MAN") ? null : Colors.amberAccent)),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
