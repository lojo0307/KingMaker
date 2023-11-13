import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/profile/profile_char_image_widget.dart';
import 'package:provider/provider.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}




class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final TextEditingController _nicknameController = TextEditingController();


  @override
  void dispose() {
    // 위젯이 소멸될 때 컨트롤러를 정리합니다.
    _nicknameController.dispose();
    super.dispose();
  }

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
                          controller: _nicknameController,
                          decoration: const InputDecoration(
                            hintText: '닉네임',
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
    String nickname = _nicknameController.text;
    RegExp nicknameRegExp = RegExp(r'^[a-zA-Z0-9_-가-힣]+$');
    print(nickname);
    print(nickname.length);
    if (nickname.isEmpty) {
      _showDialog('수정 실패!', '닉네임을 입력해주세요');
    } else if (nickname.length > 10) {
      _showDialog('수정 실패!', '10글자 이하의 닉네임을 입력해주세요');
    } else if (nicknameRegExp.hasMatch(nickname)) {
      _showDialog('수정 실패!', '닉네임에는 특수 문자나 아이콘을 사용할 수 없습니다');
    } else {
      try {
        Provider.of<MemberProvider>(context, listen: false).modifyNickName(nickname);
        // 업데이트 성공 후 성공 메시지를 보여주고 이전 페이지로 닉네임을 전달합니다.
        _showDialog('성공', '닉네임을 수정했습니다');
        Navigator.pop(context, nickname); // 변경된 닉네임을 결과로 전달합니다.
      } catch (e) {
        _showDialog('수정 실패!', '닉네임 수정에 문제가 발생했습니다: $e');
      }
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            // 사용자가 "확인" 버튼을 누르면 다이얼로그를 닫습니다.
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                if (title != '성공') {
                  Navigator.of(context).pop();
                }else{
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
  
}
