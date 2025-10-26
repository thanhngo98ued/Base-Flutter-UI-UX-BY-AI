import 'package:base/presentation/pages/reset_password/bloc/bloc.dart';
import 'package:base/presentation/pages/reset_password/pages/reset_password.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Reset Password Flow - Quản lý routing và dependencies cho Reset Password module
class ResetPasswordFlow {
  ResetPasswordFlow._();

  static const String path = '/reset-password';
  static const String name = 'reset-password';

  /// Tạo GoRoute cho Reset Password
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        final phone = state.extra as String? ?? '0901234567';
        return MaterialPage(
          child: BlocProvider(
            create: (context) => ResetPasswordBloc(),
            child: ResetPasswordPage(phone: phone),
          ),
        );
      },
    );
  }
}

