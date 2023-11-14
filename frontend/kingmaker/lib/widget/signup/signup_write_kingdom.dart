import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class SignupWriteKingdom extends StatefulWidget {
  const SignupWriteKingdom({super.key});

  @override
  State<SignupWriteKingdom> createState() => _SignupWriteKingdomState();
}

class _SignupWriteKingdomState extends State<SignupWriteKingdom> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<KingdomProvider>(
        builder: (context, provider, child) {
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
                                provider.setName(value);
                                setState(() {});
                              },
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(provider.errorMessage,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red
                      ),
                    ),
                  ],
                ),
              ],
            );
        }
    );
  }
}