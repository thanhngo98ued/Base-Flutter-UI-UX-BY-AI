import 'package:base/data/repository/source/remote/api/error/api_error.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin AppErrorHandler {
  void handleAppError({
    required BuildContext context,
    required Object exception,
  }) {
    if (exception is ApiError) {
      _handleApiError(context, exception);
    } else {
      _showErrorDialog(
        context: context,
        title: 'Lỗi không xác định',
        message: 'Đã xảy ra lỗi. Vui lòng thử lại sau.',
      );
    }
  }

  void _handleApiError(BuildContext context, ApiError exception) {
    String title = 'Lỗi';
    String message = exception.errorMessage;

    switch (exception) {
      case ServerError():
        title = 'Lỗi máy chủ (${exception.statusCode ?? 'Unknown'})';
        break;
      case NetworkError():
        title = 'Lỗi kết nối';
        break;
      case HttpError():
        title = 'Lỗi HTTP (${exception.statusCode ?? 'Unknown'})';
        break;
      case UnexpectedError():
        title = 'Lỗi không xác định';
        break;
    }

    _showErrorDialog(context: context, title: title, message: message);
  }

  void _showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        ),
        elevation: 8,
        backgroundColor: AppColors.backgroundLight,
        child: Container(
          constraints: BoxConstraints(maxWidth: 340.w),
          padding: EdgeInsets.all(AppDimensions.paddingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 24.w,
                  color: AppColors.error,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.black,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeightSM,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMD,
                      ),
                    ),
                  ),
                  child: Text(
                    'Đã hiểu',
                    style: AppTextStyles.button.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
