import 'package:flutter/material.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _kingdomNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nicknameController.dispose();
    _kingdomNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원정보수정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kingdomNameController,
              decoration: const InputDecoration(
                labelText: '왕국 이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateProfileInformation,
              child: const Text('Update Information'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfileInformation() {
    // Use these values to update the user profile information
    final String nickname = _nicknameController.text;
    final String kingdomName = _kingdomNameController.text;
    final String email = _emailController.text;

    // Implement your update logic here
    print('Nickname: $nickname, Kingdom Name: $kingdomName, Email: $email');
  }
}
