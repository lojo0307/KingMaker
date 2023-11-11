import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class SignupWriteName extends StatefulWidget {
  const SignupWriteName({super.key});

  @override
  State<SignupWriteName> createState() => _SignupWriteNameState();
}

class _SignupWriteNameState extends State<SignupWriteName> {
  @override
  void initState() {
    Provider.of<MemberProvider>(context, listen: false).setErrorFirst();
    super.initState();
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
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // 상하 패딩 조절
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
                onPressed: () {},
                child: const Text("랜덤 생성", style: TextStyle(color: BLUE_BLACK_COLOR),),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),padding: EdgeInsets.symmetric(horizontal: 16),backgroundColor: LIGHT_YELLOW_COLOR),

              ),
            ],
          ),
          Text(
            provider.errorMessage,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      );
    });
  }
}
