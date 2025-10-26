import 'package:base/presentation/pages/forgot_password/pages/forgot_password.screen.dart';
import 'package:base/presentation/pages/forgot_password/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// ForgotPassword Page - wrapper với dependencies và navigation handling
/// 
/// Chứa:
/// - Scaffold
/// - BlocListener để xử lý navigation dựa trên state
/// - Error handling
/// - Common layout
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            // Xử lý navigation dựa trên state
            if (state.status == ForgotPasswordStatus.success) {
              // Show success message and navigate to OTP
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã gửi mã OTP đến số điện thoại'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
              // Navigate to OTP with phone number and context (forgot password)
              context.push('/otp', extra: {
                'phone': state.phone,
                'from': 'forgot-password',
              });
            } else if (state.status == ForgotPasswordStatus.failure) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Đã xảy ra lỗi'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: const ForgotPasswordScreen(),
        ),
      ),
    );
  }
}

