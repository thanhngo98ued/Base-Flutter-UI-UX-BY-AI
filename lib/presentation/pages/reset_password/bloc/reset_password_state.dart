import 'package:equatable/equatable.dart';

/// Trạng thái của màn Reset Password
enum ResetPasswordStatus { initial, loading, success, failure }

/// State của Reset Password BLoC
class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final String? errorMessage;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;

  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordVisible = false,
    this.errorMessage,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
  });

  /// Check có thể submit không
  bool get canSubmit => isPasswordValid && isConfirmPasswordValid;

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? password,
    String? confirmPassword,
    bool? isPasswordVisible,
    String? errorMessage,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
    );
  }

  @override
  List<Object?> get props => [
    status,
    password,
    confirmPassword,
    isPasswordVisible,
    errorMessage,
    isPasswordValid,
    isConfirmPasswordValid,
  ];

  @override
  bool get stringify => true;
}
