import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:base/presentation/pages/login/pages/login.flow.dart';
import 'package:base/shared/extensions/context_ext.dart';

/// Splash Screen - Màn hình khởi động
///
/// Nhiệm vụ:
/// - Hiển thị logo và animation
/// - Tự động chuyển sang màn login sau 2 giây
/// - Không nhận callback từ bên ngoài
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Setup bounce animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: -20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Auto navigate after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(LoginFlow.path);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: child,
                  );
                },
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColors.textWhite.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.handyman,
                    size: 60.w,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                context.l10n?.callWorkerTranThi ?? '',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textWhite,
                  fontSize: 36.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Kết nối thợ chuyên nghiệp',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textWhite.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textWhite.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
