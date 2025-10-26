import 'package:base/presentation/pages/reset_password/pages/reset_password.screen.dart';
import 'package:base/presentation/pages/reset_password/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:base/router/app_router.dart';

/// Reset Password Page - wrapper với dependencies và navigation handling
class ResetPasswordPage extends StatelessWidget {
  final String phone;

  const ResetPasswordPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state.status == ResetPasswordStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đặt lại mật khẩu thành công!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
              // Navigate to login
              context.go(AppRoutes.login);
            } else if (state.status == ResetPasswordStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Đã xảy ra lỗi'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: ResetPasswordScreen(phone: phone),
        ),
      ),
    );
  }
}

