import 'package:flutter/material.dart';
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
                                provider.setName(value);
                                setState(() {});
                              },
                            ),
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
            )
          );
        }
    );
  }
}