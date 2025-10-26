import 'package:equatable/equatable.dart';

/// Base event cho OTP
abstract class OTPEvent extends Equatable {
  const OTPEvent();

  @override
  List<Object?> get props => [];
}

/// Event: User nhập OTP digit
class OTPDigitChanged extends OTPEvent {
  final int index;
  final String digit;

  const OTPDigitChanged(this.index, this.digit);

  @override
  List<Object?> get props => [index, digit];
}

/// Event: User submit OTP
class OTPSubmitted extends OTPEvent {
  const OTPSubmitted();
}

/// Event: Resend OTP
class OTPResendRequested extends OTPEvent {
  const OTPResendRequested();
}

/// Event: Timer tick
class OTPTimerTicked extends OTPEvent {
  final int duration;

  const OTPTimerTicked(this.duration);

  @override
  List<Object?> get props => [duration];
}

