import 'package:equatable/equatable.dart';

/// Base event cho Reset Password
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

/// Event: User nhập password mới
class ResetPasswordPasswordChanged extends ResetPasswordEvent {
  final String password;

  const ResetPasswordPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

/// Event: User nhập confirm password
class ResetPasswordConfirmPasswordChanged extends ResetPasswordEvent {
  final String confirmPassword;

  const ResetPasswordConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

/// Event: User nhấn nút Reset Password
class ResetPasswordSubmitted extends ResetPasswordEvent {
  const ResetPasswordSubmitted();
}

/// Event: Toggle show/hide password
class ResetPasswordPasswordVisibilityToggled extends ResetPasswordEvent {
  const ResetPasswordPasswordVisibilityToggled();
}

