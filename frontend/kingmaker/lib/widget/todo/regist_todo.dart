import 'package:flutter/material.dart';
import 'package:kingmaker/widget/common/header.dart';
class RegistTodo extends StatefulWidget {
  const RegistTodo({super.key});

  @override
  State<RegistTodo> createState() => _RegistTodoState();
}

class _RegistTodoState extends State<RegistTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF1FF),
      body: Stack(
        children: [
          Header(title: "할일 등록")
        ],
      ),
    );
  }
}
