import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/shared/components/app_input_field.dart';
import 'package:go_router/go_router.dart';

/// Deposit Screen - Màn hình nộp tiền
///
/// Nhiệm vụ:
/// - Hiển thị thông tin ngân hàng nhận tiền
/// - Hiển thị mã QR
/// - Xử lý dialog nộp tiền
class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  void _showDepositDialog(BuildContext context) {
    final amountController = TextEditingController();
    final contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppDimensions.paddingLG),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Xác nhận nộp tiền', style: AppTextStyles.h3),
              SizedBox(height: 16.h),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppInputField(
                      label: 'Số tiền (VND)',
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số tiền';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Số tiền không hợp lệ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppInputField(
                      label: 'Nội dung',
                      controller: contentController,
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập nội dung';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Hủy',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        // TODO: Handle deposit confirmation
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã gửi yêu cầu nộp tiền'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      'Xác nhận',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Nộp tiền'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          children: [
            // Bank info card
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: AppColors.primary,
                        size: 32.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text('Thông tin ngân hàng', style: AppTextStyles.h3),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  _buildInfoRow(
                    'Ngân hàng',
                    'Vietcombank',
                    Icons.account_balance,
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoRow(
                    'Tên người nhận',
                    'NGUYEN VAN A',
                    Icons.person,
                    canCopy: true,
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoRow(
                    'Số tài khoản',
                    '1234567890',
                    Icons.credit_card,
                    canCopy: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // QR Code card
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text('Quét mã QR để nộp tiền', style: AppTextStyles.h4),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMD,
                      ),
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                    child: Column(
                      children: [
                        // Placeholder QR Code
                        Container(
                          width: 200.w,
                          height: 200.w,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSM,
                            ),
                          ),
                          child: Icon(
                            Icons.qr_code,
                            size: 120.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Vietcombank - 1234567890',
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
            SizedBox(height: 24.h),
            // Instructions
            Container(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Hướng dẫn',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _buildInstruction('1', 'Chuyển khoản đến số tài khoản trên'),
                  SizedBox(height: 8.h),
                  _buildInstruction('2', 'Nhập nội dung chuyển khoản'),
                  SizedBox(height: 8.h),
                  _buildInstruction(
                    '3',
                    'Sau khi chuyển, nhấn "Nộp tiền" để xác nhận',
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Deposit button
            AppButton(
              text: 'Nộp tiền',
              onPressed: () => _showDepositDialog(context),
              icon: Icon(
                Icons.payments,
                color: AppColors.textWhite,
                size: AppDimensions.iconSM,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    bool canCopy = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (canCopy)
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.copy, color: AppColors.primary, size: 20.sp),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã sao chép: $value'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildInstruction(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
