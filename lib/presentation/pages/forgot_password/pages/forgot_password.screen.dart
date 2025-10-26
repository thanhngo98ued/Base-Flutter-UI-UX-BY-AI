import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/shared/components/app_input_field.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/presentation/pages/forgot_password/bloc/bloc.dart';
import 'package:go_router/go_router.dart';

/// ForgotPassword Screen - Content chính của màn Quên mật khẩu
/// 
/// Nhiệm vụ:
/// - Hiển thị UI
/// - Tương tác với ForgotPasswordBloc thông qua events
/// - Không chứa navigation logic (để Page xử lý)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen to text changes and update BLoC
    _phoneController.addListener(() {
      context
          .read<ForgotPasswordBloc>()
          .add(ForgotPasswordPhoneChanged(_phoneController.text));
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordBloc>().add(const ForgotPasswordSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingLG),
              child: Container(
                constraints: BoxConstraints(maxWidth: 400.w),
                padding: EdgeInsets.all(AppDimensions.paddingXL),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: AppColors.textSecondary,
                              size: AppDimensions.iconSM,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Quay lại',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Quên mật khẩu',
                              style: AppTextStyles.h1.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Nhập số điện thoại để đặt lại mật khẩu',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      AppInputField(
                        label: 'Số điện thoại',
                        hint: 'Nhập số điện thoại của bạn',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: _handleSubmit,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          if (value.length < 10) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      AppButton(
                        text: 'Gửi yêu cầu',
                        onPressed: _handleSubmit,
                        isLoading: state.status == ForgotPasswordStatus.loading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

