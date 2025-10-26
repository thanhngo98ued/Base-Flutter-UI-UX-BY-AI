import 'package:base/presentation/pages/otp/bloc/bloc.dart';
import 'package:base/presentation/pages/otp/pages/otp.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// OTP Flow - Quản lý routing và dependencies cho OTP module
/// 
/// Nhiệm vụ:
/// - Định nghĩa route path
/// - Setup BlocProvider
/// - Xử lý parameters từ router
class OTPFlow {
  OTPFlow._(); // Private constructor để prevent instantiation

  static const String path = '/otp';
  static const String name = 'otp';

  /// Tạo GoRoute cho OTP
  static GoRoute route() {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        // Handle both String and Map formats
        String phone = '0901234567';
        String from = 'signup'; // Default from signup
        
        if (state.extra is Map) {
          final extraMap = state.extra as Map;
          phone = extraMap['phone'] as String? ?? '0901234567';
          from = extraMap['from'] as String? ?? 'signup';
        } else if (state.extra is String) {
          phone = state.extra as String;
        }
        
        return MaterialPage(
          child: BlocProvider(
            create: (context) => OTPBloc(),
            child: OTPPage(phone: phone, from: from),
          ),
        );
      },
    );
  }
}

