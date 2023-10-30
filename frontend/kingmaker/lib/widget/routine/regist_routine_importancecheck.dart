import 'package:flutter/cupertino.dart';

class ImportanceCheck extends StatefulWidget {
  const ImportanceCheck({super.key});

  @override
  State<ImportanceCheck> createState() => _ImportanceCheckState();
}

class _ImportanceCheckState extends State<ImportanceCheck> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/uncheck.png',width: 33,),
        SizedBox(width: 10,),
        Text('중요한 일정')
      ],
    );
  }
}
