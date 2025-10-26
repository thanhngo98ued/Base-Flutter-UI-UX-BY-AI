import 'package:bloc/bloc.dart';

import 'reset_password_event.dart';
import 'reset_password_state.dart';

/// BLoC cho màn Reset Password
class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<ResetPasswordPasswordChanged>(_onPasswordChanged);
    on<ResetPasswordConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ResetPasswordSubmitted>(_onSubmitted);
    on<ResetPasswordPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
  }

  /// Handler: Password thay đổi
  void _onPasswordChanged(
    ResetPasswordPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    final isValid = event.password.length >= 6;
    final isConfirmValid = event.password == state.confirmPassword;
    emit(
      state.copyWith(
        password: event.password,
        isPasswordValid: isValid,
        isConfirmPasswordValid: isConfirmValid,
      ),
    );
  }

  /// Handler: Confirm password thay đổi
  void _onConfirmPasswordChanged(
    ResetPasswordConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    final isValid = event.confirmPassword == state.password;
    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        isConfirmPasswordValid: isValid,
      ),
    );
  }

  /// Handler: Submit reset password
  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: ResetPasswordStatus.loading));

    try {
      // TODO: Call API reset password tại đây
      // await authRepository.resetPassword(phone, newPassword);

      // Giả lập API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: ResetPasswordStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: 'Đã xảy ra lỗi: $error',
        ),
      );
    }
  }

  /// Handler: Toggle password visibility
  void _onPasswordVisibilityToggled(
    ResetPasswordPasswordVisibilityToggled event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }
}

