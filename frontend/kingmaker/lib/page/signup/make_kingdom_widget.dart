import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';
class MakeKingDomPage extends StatefulWidget {
  const MakeKingDomPage({super.key});

  @override
  State<MakeKingDomPage> createState() => _MakeKingDomPageState();
}

class _MakeKingDomPageState extends State<MakeKingDomPage> {
  int mainColor = 0xFFEDF1FF;
  String kingdomName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(mainColor),
      body: SingleChildScrollView(
        child:Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                const ProfileCharImageWidget(),
                const Text('당신은 왕국의 태조입니다.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('왕국의 이름은?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                kingdomName = value;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavBar()), (route) => false
                  );
                }, child: const Text("건국하기")),
              ],
            ),
            TextButton(onPressed: () {
              Navigator.pop(
                context,
              );
            }, child: const Icon(CupertinoIcons.back)),
          ],
        )
      ),
    );
  }
}