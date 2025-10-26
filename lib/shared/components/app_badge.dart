import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';

enum AppBadgeType { success, error, warning, info, primary }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeType type;
  final bool isSmall;

  const AppBadge({
    super.key,
    required this.text,
    this.type = AppBadgeType.primary,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (type) {
      AppBadgeType.success => AppColors.success,
      AppBadgeType.error => AppColors.error,
      AppBadgeType.warning => AppColors.warning,
      AppBadgeType.info => AppColors.info,
      AppBadgeType.primary => AppColors.primary,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6.w : 8.w,
        vertical: isSmall ? 2.h : 4.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      ),
      child: Text(
        text,
        style: (isSmall ? AppTextStyles.captionBold : AppTextStyles.labelSmall)
            .copyWith(
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}

