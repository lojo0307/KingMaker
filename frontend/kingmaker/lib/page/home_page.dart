import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/main/main_expbar.dart';
import 'package:kingmaker/widget/main/main_game.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [

          GameWidget.controlled(
              gameFactory:()=> MyGame(context,)
          ),
          ExpBar(),
        ],
      )
    );
  }
}

