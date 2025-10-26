import 'package:equatable/equatable.dart';

/// Trạng thái của màn ForgotPassword
enum ForgotPasswordStatus {
  initial,
  loading,
  success,
  failure,
}

/// State của ForgotPassword BLoC
class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final String phone;
  final String? errorMessage;
  final bool isPhoneValid;

  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.phone = '',
    this.errorMessage,
    this.isPhoneValid = false,
  });

  /// Check có thể submit không
  bool get canSubmit => isPhoneValid;

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? phone,
    String? errorMessage,
    bool? isPhoneValid,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      errorMessage: errorMessage,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        phone,
        errorMessage,
        isPhoneValid,
      ];

  @override
  bool get stringify => true;
}

