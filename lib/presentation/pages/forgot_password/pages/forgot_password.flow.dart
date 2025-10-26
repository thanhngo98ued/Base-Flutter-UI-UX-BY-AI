import 'package:base/presentation/pages/forgot_password/bloc/bloc.dart';
import 'package:base/presentation/pages/forgot_password/pages/forgot_password.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// ForgotPassword Flow - Quản lý routing và dependencies cho ForgotPassword module
/// 
/// Nhiệm vụ:
/// - Định nghĩa route path
/// - Setup BlocProvider
/// - Cung cấp helper methods cho navigation
class ForgotPasswordFlow {
  ForgotPasswordFlow._(); // Private constructor để prevent instantiation

  static const String path = '/forgot-password';
  static const String name = 'forgot-password';

  /// Tạo GoRoute cho ForgotPassword
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: BlocProvider(
            create: (context) => ForgotPasswordBloc(),
            child: const ForgotPasswordPage(),
          ),
        );
      },
    );
  }
}

