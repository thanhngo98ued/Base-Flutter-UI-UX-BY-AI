import 'package:base/presentation/pages/otp/pages/otp.screen.dart';
import 'package:base/presentation/pages/otp/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:base/router/app_router.dart';

/// OTP Page - wrapper với dependencies và navigation handling
///
/// Chứa:
/// - Scaffold
/// - BlocListener để xử lý navigation dựa trên state
/// - Error handling
/// - Common layout
class OTPPage extends StatelessWidget {
  final String phone;
  final String from; // 'signup' or 'forgot-password'

  const OTPPage({super.key, required this.phone, this.from = 'signup'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OTPBloc, OTPState>(
          listener: (context, state) {
            // Xử lý navigation dựa trên state
            if (state.status == OTPStatus.success) {
              // Navigate based on context
              if (from == 'forgot-password') {
                // From forgot password → go to reset password screen
                context.go('/reset-password', extra: phone);
              } else {
                // From signup → go to main screen
                context.go(AppRoutes.main);
              }
            } else if (state.status == OTPStatus.failure) {
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
          child: OTPScreen(phone: phone),
        ),
      ),
    );
  }
}
