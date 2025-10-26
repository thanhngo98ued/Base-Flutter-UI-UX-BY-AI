import 'package:base/presentation/pages/profile/screens/profile.screen.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:flutter/material.dart';

/// Profile Page - wrapper với navigation handling
/// 
/// Chứa:
/// - Scaffold
/// - Navigation handling
/// - Common layout
class ProfilePage extends StatelessWidget {
  final UserModel? user;

  const ProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: Lấy user từ BLoC/Provider nếu null
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hồ sơ cá nhân')),
        body: const Center(child: Text('Không tìm thấy thông tin người dùng')),
      );
    }

    return ProfileScreen(user: user!);
  }
}

