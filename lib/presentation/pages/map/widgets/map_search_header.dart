import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';

/// Map Search Header - Header với search field
class MapSearchHeader extends StatelessWidget {
  final VoidCallback onSearchTap;

  const MapSearchHeader({
    super.key,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: GestureDetector(
            onTap: onSearchTap,
            child: AbsorbPointer(
              child: TextField(
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Tìm thợ theo tên hoặc kỹ năng...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textTertiary,
                    size: 20.sp,
                  ),
                  filled: true,
                  fillColor: AppColors.backgroundDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMD,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMD,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.border,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMD,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

