import 'package:equatable/equatable.dart';

/// Base event cho ForgotPassword
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

/// Event: User nhập phone
class ForgotPasswordPhoneChanged extends ForgotPasswordEvent {
  final String phone;

  const ForgotPasswordPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

/// Event: User nhấn nút Submit
class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  const ForgotPasswordSubmitted();
}

