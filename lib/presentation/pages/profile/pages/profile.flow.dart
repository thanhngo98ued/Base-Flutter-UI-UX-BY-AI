import 'package:base/presentation/pages/profile/pages/profile.page.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Profile Flow - Quản lý routing cho Profile module
/// 
/// Nhiệm vụ:
/// - Định nghĩa route path
/// - Xử lý parameters từ router
class ProfileFlow {
  ProfileFlow._(); // Private constructor để prevent instantiation

  static const String path = '/profile';
  static const String name = 'profile';

  /// Tạo GoRoute cho Profile
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        final user = state.extra as UserModel?;
        return MaterialPage(
          child: ProfilePage(user: user),
        );
      },
    );
  }
}

