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
import 'package:base/presentation/pages/signup/bloc/bloc.dart';
import 'package:base/presentation/pages/signup/widgets/index.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _yearsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    context.read<SignupBloc>().add(const SignupSubmitted());
  }

  void _handleLogin() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return BlocPageBuilder<SignupBloc, SignupUiState>(
      child: BlocBuilder<SignupBloc, PageState<SignupUiState>>(
        builder: (context, state) {
          final uiState = state.uiState;
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tạo tài khoản',
                              style: AppTextStyles.h1.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Đăng ký để bắt đầu',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 32.h),
                            BlocBuilder<SignupBloc, PageState<SignupUiState>>(
                              buildWhen: (previous, current) =>
                                  previous.uiState.nameError !=
                                  current.uiState.nameError,
                              builder: (context, state) {
                                return AppInputField(
                                  label: 'Họ và tên',
                                  hint: 'Nhập họ và tên',
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                  errorText: state.uiState.nameError,
                                  onChanged: (value) {
                                    context.read<SignupBloc>().add(
                                      SignupNameChanged(value),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập họ và tên';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 16.h),
                            BlocBuilder<SignupBloc, PageState<SignupUiState>>(
                              buildWhen: (previous, current) =>
                                  previous.uiState.phone !=
                                      current.uiState.phone ||
                                  previous.uiState.phoneError !=
                                      current.uiState.phoneError,
                              builder: (context, state) {
                                return AppInputField(
                                  label: 'Số điện thoại',
                                  hint: 'Nhập số điện thoại',
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  errorText: state.uiState.phoneError,
                                  onChanged: (value) {
                                    context.read<SignupBloc>().add(
                                      SignupPhoneChanged(value),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập số điện thoại';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 16.h),
                            const ProvinceSelector(),
                            SizedBox(height: 16.h),
                            const RoleSelector(),
                            if (uiState.role == 'worker')
                              WorkerFieldsSection(
                                yearsController: _yearsController,
                                selectedSkills: uiState.selectedSkills,
                                availableSkills: uiState.availableSkills,
                                idCardFrontPath: uiState.idCardFrontPath,
                                idCardBackPath: uiState.idCardBackPath,
                                isLoadingSkills: uiState.isLoadingMasterData,
                                onYearsChanged: (value) {
                                  final years = int.tryParse(value) ?? 0;
                                  context.read<SignupBloc>().add(
                                    SignupYearsOfExperienceChanged(years),
                                  );
                                },
                              ),

                            SizedBox(height: 16.h),
                            BlocBuilder<SignupBloc, PageState<SignupUiState>>(
                              buildWhen: (previous, current) =>
                                  previous.uiState.password !=
                                      current.uiState.password ||
                                  previous.uiState.confirmPassword !=
                                      current.uiState.confirmPassword ||
                                  previous.uiState.passwordError !=
                                      current.uiState.passwordError,
                              builder: (context, state) {
                                final currentUiState = state.uiState;
                                return Column(
                                  children: [
                                    AppInputField(
                                      label: 'Mật khẩu',
                                      hint: 'Nhập mật khẩu',
                                      controller: _passwordController,
                                      obscureText: true,
                                      textInputAction: TextInputAction.next,
                                      errorText: currentUiState.passwordError,
                                      onChanged: (value) {
                                        context.read<SignupBloc>().add(
                                          SignupPasswordChanged(value),
                                        );
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Vui lòng nhập mật khẩu';
                                        }
                                        if (value.length < 6) {
                                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    AppInputField(
                                      label: 'Xác nhận mật khẩu',
                                      hint: 'Nhập lại mật khẩu',
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      textInputAction: TextInputAction.done,
                                      onEditingComplete: _handleSignup,
                                      onChanged: (value) {
                                        context.read<SignupBloc>().add(
                                          SignupConfirmPasswordChanged(value),
                                        );
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Vui lòng nhập lại mật khẩu';
                                        }
                                        if (value != currentUiState.password) {
                                          return 'Mật khẩu không khớp';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            AppButton(
                              text: 'Đăng ký',
                              onPressed: _handleSignup,
                              enabled: uiState.canSubmit,
                              isLoading: state.isLoading,
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Đã có tài khoản? ',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _handleLogin,
                                  child: Text(
                                    'Đăng nhập',
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
              ),
            ),
          );
        },
      ),
    );
  }
}
