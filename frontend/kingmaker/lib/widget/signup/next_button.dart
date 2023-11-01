import 'package:flutter/material.dart';
import 'package:kingmaker/page/signup/make_kingdom_widget.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:provider/provider.dart';

class NextButton extends StatefulWidget {
  const NextButton({super.key});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return ElevatedButton(onPressed: () {
            if (provider.member?.nickname != "" && provider.errorMessage == " "){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MakeKingDomPage())
              );
            }
          }, child: const Text("다음 단계로"));
        }
    );
  }
}
