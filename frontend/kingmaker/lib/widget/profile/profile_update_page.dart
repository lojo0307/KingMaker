import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/main.dart';
import 'package:kingmaker/page/login_page.dart';
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
            centerTitle: true,
            title: Text('회원 정보', style: TextStyle(fontSize: 16, fontFamily: 'EsamanruMedium'),),
            backgroundColor: LIGHTEST_BLUE_COLOR,
            leading: IconButton(
              icon: SvgPicture.asset('assets/icon/ic_left.svg', height: 24,),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView( // SingleChildScrollView 추가
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
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
                        child: TextFormField(
                          controller: _nicknameController,
                          decoration: InputDecoration(
                            hintText: '닉네임을 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // 일반 상태에서는 테두리 없음
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none, // 비활성화 상태에서도 테두리 없음
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 1), // 포커스 상태에서 두꺼운 테두리
                            ),
                            filled: true,
                            fillColor: WHITE_COLOR,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _updateProfileInformation,
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            backgroundColor: LIGHT_YELLOW_COLOR),
                        child: const Text(
                          '닉네임 수정하기',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<MemberProvider>(context,listen: false).deleteMember();
                          final globalcontext = navigatorKey1.currentContext;
                          Navigator.pushAndRemoveUntil(
                            globalcontext!,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                                (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            backgroundColor: LIGHT_RED_COLOR),
                        child: const Text(
                          '회원 탈퇴',
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
