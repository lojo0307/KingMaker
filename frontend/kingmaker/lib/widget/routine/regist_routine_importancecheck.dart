import 'package:flutter/cupertino.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:provider/provider.dart';

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
        GestureDetector(
          onTap: () {
            Provider.of<RegistProvider>(context, listen: false).changeImport();
            setState(() {});
            print(Provider.of<RegistProvider>(context, listen: false).importantYn);
          },
          child: (Provider.of<RegistProvider>(context, listen: false).importantYn)? Image.asset('assets/images/check.png',width: 33,) :Image.asset('assets/images/uncheck.png',width: 33,),
        ),
        SizedBox(width: 10,),
        Text('중요한 일정')
      ],
    );
  }
}
