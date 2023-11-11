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
                                border: OutlineInputBorder(),
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
                Text(provider.errorMessage,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ),
                ),
              ],
            );
        }
    );
  }
}