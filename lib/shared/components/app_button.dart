import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';

enum AppButtonType { primary, secondary, outline, text }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool enabled;
  final bool isFullWidth;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.small,
    this.isLoading = false,
    this.enabled = true,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !enabled || isLoading;
    
    final double height = switch (size) {
      AppButtonSize.small => AppDimensions.buttonHeightSM,
      AppButtonSize.medium => AppDimensions.buttonHeightMD,
      AppButtonSize.large => AppDimensions.buttonHeightLG,
    };

    final TextStyle textStyle = switch (size) {
      AppButtonSize.small => AppTextStyles.buttonSmall,
      _ => AppTextStyles.button,
    };

    Widget buttonChild = isLoading
        ? SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == AppButtonType.primary
                    ? AppColors.textWhite
                    : AppColors.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, SizedBox(width: 8.w)],
              Text(text, style: textStyle),
            ],
          );

    Widget button = switch (type) {
      AppButtonType.primary => ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled 
              ? AppColors.border 
              : (backgroundColor ?? AppColors.primary),
          foregroundColor: isDisabled 
              ? AppColors.textSecondary 
              : (textColor ?? AppColors.textWhite),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
        ),
        child: buttonChild,
      ),
      AppButtonType.secondary => ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled 
              ? AppColors.border 
              : (backgroundColor ?? AppColors.secondary),
          foregroundColor: isDisabled 
              ? AppColors.textSecondary 
              : (textColor ?? AppColors.textWhite),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
        ),
        child: buttonChild,
      ),
      AppButtonType.outline => OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: isDisabled 
              ? AppColors.textSecondary 
              : (textColor ?? AppColors.primary),
          side: BorderSide(
            color: isDisabled 
                ? AppColors.border 
                : (backgroundColor ?? AppColors.primary),
            width: 1.5,
          ),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
        ),
        child: buttonChild,
      ),
      AppButtonType.text => TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: isDisabled 
              ? AppColors.textSecondary 
              : (textColor ?? AppColors.primary),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMD),
        ),
        child: buttonChild,
      ),
    };

    return button;
  }
}
