import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
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
    return Consumer<MemberProvider>(builder: (context, provider, child) {
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
                image: (provider.member?.gender == "WOMAN")
                    ? AssetImage('assets/character/charWoman.png')
                    : AssetImage('assets/character/charMan.png'),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.genderToMale();
                    setState(() {});
                  },
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: (provider.member?.gender == "WOMAN")
                            ? null
                            : DARK_BLUE_COLOR,
                      ),
                      child: SvgPicture.asset(
                        'assets/icon/ic_male.svg',
                        color: provider.member?.gender == "WOMAN"
                            ? GREY_COLOR
                            : WHITE_COLOR,
                      )),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    provider.genderToMale();
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: !(provider.member?.gender == "WOMAN")
                          ? null
                          : DARK_BLUE_COLOR,
                    ),
                    child: SvgPicture.asset(
                      'assets/icon/ic_female.svg',
                      color: !(provider.member?.gender == "WOMAN")
                          ? GREY_COLOR
                          : WHITE_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
