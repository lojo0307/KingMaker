import 'package:flutter/material.dart';
import 'package:kingmaker/provider/test_provider.dart';

import '../dto/test_dto.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    TestProvider.getData();
    return Container(
      child: TextButton(
          onPressed: () {
            TestProvider.getData();
            print('Page에서의 데이터');
            print(TestProvider.name);
            print(TestProvider.age);
            print(TestProvider.city);
            print('============================');
          },
          child: Text("데이터 가져오기")
      ),
    );
  }
}
