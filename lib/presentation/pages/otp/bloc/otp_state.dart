import 'package:equatable/equatable.dart';

/// Trạng thái của màn OTP
enum OTPStatus {
  initial,
  loading,
  success,
  failure,
}

/// State của OTP BLoC
class OTPState extends Equatable {
  final OTPStatus status;
  final List<String> digits;
  final String? errorMessage;
  final int timerDuration;
  final bool canResend;

  const OTPState({
    this.status = OTPStatus.initial,
    this.digits = const ['', '', '', '', '', ''],
    this.errorMessage,
    this.timerDuration = 60,
    this.canResend = false,
  });

  /// Check có thể submit không
  bool get canSubmit => digits.every((d) => d.isNotEmpty);

  /// Get OTP string
  String get otp => digits.join();

  OTPState copyWith({
    OTPStatus? status,
    List<String>? digits,
    String? errorMessage,
    int? timerDuration,
    bool? canResend,
  }) {
    return OTPState(
      status: status ?? this.status,
      digits: digits ?? this.digits,
      errorMessage: errorMessage,
      timerDuration: timerDuration ?? this.timerDuration,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [
        status,
        digits,
        errorMessage,
        timerDuration,
        canResend,
      ];

  @override
  bool get stringify => true;
}

