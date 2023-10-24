import 'package:flutter/material.dart';
import 'package:kingmaker/widget/common/header.dart';
class RegistRoutine extends StatefulWidget {
  const RegistRoutine({super.key});

  @override
  State<RegistRoutine> createState() => _RegistRoutineState();
}

class _RegistRoutineState extends State<RegistRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1FF),
      body: Stack(
        children: [
          Header(title: "루틴 등록")
        ],
      ),
    );
  }
}
