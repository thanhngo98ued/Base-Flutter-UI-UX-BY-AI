import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base/presentation/resources/app_colors.dart';
import 'package:base/presentation/resources/app_text_styles.dart';
import 'package:base/presentation/resources/app_dimensions.dart';
import 'package:base/presentation/base/bloc_page_builder.dart';
import 'package:base/presentation/base/page_state.dart';
import 'package:base/shared/components/app_input_field.dart';
import 'package:base/shared/components/app_button.dart';
import 'package:base/presentation/pages/login/bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:base/shared/extensions/context_ext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(() {
      context.read<LoginCubit>().onPhoneChanged(_phoneController.text);
    });
    _passwordController.addListener(() {
      context.read<LoginCubit>().onPasswordChanged(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login();
    }
  }

  void _handleForgotPassword() {
    context.push('/forgot-password');
  }

  void _handleSignup() {
    context.push('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return BlocPageBuilder<LoginCubit, LoginUiState>(
      showLoading: false,
      child: BlocBuilder<LoginCubit, PageState<LoginUiState>>(
        builder: (context, state) {
          final uiState = state.uiState;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
            ),
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
                      children: [
                        Text(
                          context.l10n?.callWorkerTranThi ?? '',
                          style: AppTextStyles.h1.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Đăng nhập để tiếp tục',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        AppInputField(
                          label: 'Số điện thoại',
                          hint: 'Nhập số điện thoại',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
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
                        SizedBox(height: 16.h),
                        AppInputField(
                          label: 'Mật khẩu',
                          hint: 'Nhập mật khẩu',
                          controller: _passwordController,
                          obscureText: !uiState.isPasswordVisible,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _handleLogin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _handleForgotPassword,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                            ),
                            child: Text(
                              'Quên mật khẩu?',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        AppButton(
                          text: 'Đăng nhập',
                          onPressed: _handleLogin,
                          isLoading: state.isLoading,
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chưa có tài khoản? ',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: _handleSignup,
                              child: Text(
                                'Đăng ký ngay',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
