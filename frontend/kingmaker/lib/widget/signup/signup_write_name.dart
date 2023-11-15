import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class SignupWriteName extends StatefulWidget {
  const SignupWriteName({super.key});

  @override
  State<SignupWriteName> createState() => _SignupWriteNameState();
}

class _SignupWriteNameState extends State<SignupWriteName> {
  TextEditingController _controller=TextEditingController();

  @override
  void initState() {
    Provider.of<MemberProvider>(context, listen: false).setErrorFirst();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  String generateRandomName() {
    List<String> names = ["카를","콘래드","볼드윈","발데마르","에드워드","헨리","루드비히","페르디난드","알폰소","태조 이방세"]; // 이름 배열
    Random random = Random();
    int index = random.nextInt(names.length);
    return names[index];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvider>(builder: (context, provider, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Center(
                  child: Container(
                    height: 48.0,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // 상하 패딩 조절
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none, // 일반 상태에서는 테두리 없음
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none, // 비활성화 상태에서도 테두리 없음
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1), // 포커스 상태에서 두꺼운 테두리
                        ),
                        filled: true,
                        fillColor: WHITE_COLOR,
                      ),
                      onChanged: (value) {
                        provider.setNickName(value);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              ElevatedButton(
                onPressed: () {
                  String randomName = generateRandomName();
                  _controller.text = randomName;
                  provider.setNickName(randomName);
                  setState(() {}); // UI 갱신
                },
                child: const Text("랜덤 생성", style: TextStyle(color: BLUE_BLACK_COLOR),),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),padding: EdgeInsets.symmetric(horizontal: 16),backgroundColor: LIGHT_YELLOW_COLOR),

              ),
            ],
          ),
          SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                provider.errorMessage,
                style: TextStyle(
                    fontSize: 12, color: Colors.red),
              ),
            ],
          ),
        ],
      );
    });
  }
}
