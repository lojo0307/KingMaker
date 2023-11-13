import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double maxWidth = constraints.maxWidth;
        double maxHeight = constraints.maxHeight;
        return Scaffold(
          backgroundColor: LIGHTEST_BLUE_COLOR,
          appBar: AppBar(
            title: const Text('닉네임 수정'),
            backgroundColor: LIGHTEST_BLUE_COLOR,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView( // SingleChildScrollView 추가
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: maxHeight), // 최소 높이를 설정하여 오버플로우 방지
                child: IntrinsicHeight( // IntrinsicHeight를 사용하여 높이를 자식 내용에 맞춤
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: maxHeight * 0.1),
                      ProfileCharImageWidget(),
                      SizedBox(height: maxHeight * 0.1),
                      Container(
                        width: maxWidth * 0.8,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: '닉네임',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _updateProfileInformation,
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(maxWidth * 0.8, 40)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Text(
                          '닉네임 수정하기',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: maxHeight * 0.1), // 추가 여백을 주어 오버플로우 방지
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateProfileInformation() {
    // 업데이트 로직을 구현하세요
  }
}
