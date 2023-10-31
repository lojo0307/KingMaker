import 'package:flutter/material.dart';
import 'package:kingmaker/provider/test_provider.dart';
import 'package:provider/provider.dart';

import '../dto/test_dto.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late TestDto testDto;
  @override
  Widget build(BuildContext context) {
    return  Consumer<TestProvider>(
        builder: (context, provider, child) {
          testDto = provider.testDto;
          return Container(
            child: TextButton(
                onPressed: () {
                  provider.getData();
                  print('Page에서의 데이터');
                  print('============================');
                },
                child: Text("$testDto")
            ),
          );
        }
    );
  }
}
