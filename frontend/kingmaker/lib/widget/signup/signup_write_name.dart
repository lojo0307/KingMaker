import 'package:flutter/material.dart';
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
    return Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: Colors.white,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                provider.setNickName(value);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {
                    }, child: const Text("랜덤 생성")),
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
            ),
          );
        }
    );
  }
}