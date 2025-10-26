import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';

/// App Confirm Dialog - Dialog xác nhận với 2 button
///
/// Sử dụng cho các trường hợp cần xác nhận như:
/// - Xóa tài khoản
/// - Xóa dữ liệu
/// - Thoát ứng dụng
/// - Hủy đơn hàng
class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  final String positiveText;
  final String negativeText;
  final VoidCallback onPositive;
  final VoidCallback onNegative;
  final Color? positiveColor;
  final Color? negativeColor;
  final bool isDestructive;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.description,
    required this.positiveText,
    required this.negativeText,
    required this.onPositive,
    required this.onNegative,
    this.positiveColor,
    this.negativeColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      ),
      backgroundColor: AppColors.backgroundLight,
      child: Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Description
            Text(
              description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                // Negative button
                Expanded(
                  child: _buildButton(
                    text: negativeText,
                    onPressed: onNegative,
                    isPrimary: false,
                    color: negativeColor,
                  ),
                ),
                SizedBox(width: 12.w),

                // Positive button
                Expanded(
                  child: _buildButton(
                    text: positiveText,
                    onPressed: onPositive,
                    isPrimary: true,
                    color: positiveColor,
                    isDestructive: isDestructive,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
    Color? color,
    bool isDestructive = false,
  }) {
    final buttonColor =
        color ?? (isDestructive ? AppColors.error : AppColors.primary);

    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: isPrimary ? buttonColor : AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(
          color: isPrimary ? buttonColor : AppColors.border,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isPrimary
                    ? AppColors.textWhite
                    : (isDestructive ? AppColors.error : AppColors.textPrimary),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Show confirm dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String description,
    required String positiveText,
    required String negativeText,
    required VoidCallback onPositive,
    required VoidCallback onNegative,
    Color? positiveColor,
    Color? negativeColor,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppConfirmDialog(
        title: title,
        description: description,
        positiveText: positiveText,
        negativeText: negativeText,
        onPositive: onPositive,
        onNegative: onNegative,
        positiveColor: positiveColor,
        negativeColor: negativeColor,
        isDestructive: isDestructive,
      ),
    );
  }
}

/// Predefined dialogs for common use cases
class AppConfirmDialogs {
  /// Delete account dialog
  static Future<bool?> showDeleteAccount({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return AppConfirmDialog.show(
      context: context,
      title: 'Xóa tài khoản',
      description:
          'Bạn có chắc chắn muốn xóa tài khoản? Hành động này không thể hoàn tác.',
      positiveText: 'Xóa',
      negativeText: 'Hủy',
      onPositive: () {
        Navigator.of(context).pop(true);
        onConfirm();
      },
      onNegative: () => Navigator.of(context).pop(false),
      isDestructive: true,
    );
  }

  /// Logout dialog
  static Future<bool?> showLogout({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return AppConfirmDialog.show(
      context: context,
      title: 'Đăng xuất',
      description: 'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?',
      positiveText: 'Đăng xuất',
      negativeText: 'Hủy',
      onPositive: () {
        Navigator.of(context).pop(true);
        onConfirm();
      },
      onNegative: () => Navigator.of(context).pop(false),
    );
  }

  /// Delete item dialog
  static Future<bool?> showDeleteItem({
    required BuildContext context,
    required String itemName,
    required VoidCallback onConfirm,
  }) {
    return AppConfirmDialog.show(
      context: context,
      title: 'Xóa $itemName',
      description:
          'Bạn có chắc chắn muốn xóa $itemName? Hành động này không thể hoàn tác.',
      positiveText: 'Xóa',
      negativeText: 'Hủy',
      onPositive: () {
        Navigator.of(context).pop(true);
        onConfirm();
      },
      onNegative: () => Navigator.of(context).pop(false),
      isDestructive: true,
    );
  }

  /// Cancel order dialog
  static Future<bool?> showCancelOrder({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return AppConfirmDialog.show(
      context: context,
      title: 'Hủy đơn hàng',
      description: 'Bạn có chắc chắn muốn hủy đơn hàng này?',
      positiveText: 'Hủy đơn',
      negativeText: 'Không',
      onPositive: () {
        Navigator.of(context).pop(true);
        onConfirm();
      },
      onNegative: () => Navigator.of(context).pop(false),
      isDestructive: true,
    );
  }
}





