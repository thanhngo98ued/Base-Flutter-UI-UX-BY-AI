import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/pages/signup/bloc/bloc.dart';
import 'package:base/presentation/pages/signup/widgets/id_card_upload_widget.dart';

class IdCardSection extends StatelessWidget {
  const IdCardSection({
    super.key,
    required this.frontPath,
    required this.backPath,
  });

  final String? frontPath;
  final String? backPath;

  Future<void> _pickIdCardImage(BuildContext context, bool isFront) async {
    final imageSource = await _showImageSourceDialog(context);
    if (imageSource == null) return;

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: imageSource,
      imageQuality: 80,
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (image != null) {
      if (isFront) {
        context.read<SignupBloc>().add(SignupIdCardFrontUploaded(image.path));
      } else {
        context.read<SignupBloc>().add(SignupIdCardBackUploaded(image.path));
      }
    }
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.textWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLG),
          topRight: Radius.circular(AppDimensions.radiusLG),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingMD),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Text('Chọn ảnh CCCD', style: AppTextStyles.h2),
                SizedBox(height: 16.h),
                _ImageSourceOption(
                  icon: Icons.camera_alt,
                  title: 'Chụp ảnh',
                  subtitle: 'Sử dụng camera',
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                SizedBox(height: 8.h),
                _ImageSourceOption(
                  icon: Icons.photo_library,
                  title: 'Thư viện ảnh',
                  subtitle: 'Chọn từ thư viện',
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
                SizedBox(height: 8.h),
                _ImageSourceOption(
                  icon: Icons.close,
                  title: 'Hủy',
                  subtitle: 'Đóng hộp thoại',
                  onTap: () => Navigator.pop(context),
                  isCancel: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Căn cước công dân', style: AppTextStyles.label),
        SizedBox(height: 8.h),
        Text(
          'Upload 2 mặt của CCCD',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: IdCardUploadWidget(
                label: 'Mặt trước',
                imagePath: frontPath,
                onTap: () => _pickIdCardImage(context, true),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: IdCardUploadWidget(
                label: 'Mặt sau',
                imagePath: backPath,
                onTap: () => _pickIdCardImage(context, false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  const _ImageSourceOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isCancel = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingSM),
        decoration: BoxDecoration(
          color: isCancel
              ? AppColors.error.withOpacity(0.1)
              : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(
            color: isCancel
                ? AppColors.error.withOpacity(0.3)
                : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: isCancel
                    ? AppColors.error.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                icon,
                color: isCancel ? AppColors.error : AppColors.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isCancel ? AppColors.error : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
