import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';

class IdCardUploadWidget extends StatelessWidget {
  const IdCardUploadWidget({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onTap,
  });

  final String label;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: hasImage
              ? AppColors.success.withOpacity(0.1)
              : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(
            color: hasImage ? AppColors.success : AppColors.border,
            width: 2,
          ),
        ),
        child: hasImage ? _buildImagePreview() : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD - 2),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.file(
              File(imagePath!),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: AppColors.textWhite,
              size: 16.sp,
            ),
          ),
        ),
        Positioned(
          bottom: 8.h,
          left: 8.w,
          right: 8.w,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.9),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'Đã chọn',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate,
          size: 32.w,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

