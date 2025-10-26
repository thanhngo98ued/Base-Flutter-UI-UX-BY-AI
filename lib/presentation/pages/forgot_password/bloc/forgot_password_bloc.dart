import 'package:bloc/bloc.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

/// BLoC cho màn ForgotPassword
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordPhoneChanged>(_onPhoneChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  /// Handler: Phone thay đổi
  void _onPhoneChanged(
    ForgotPasswordPhoneChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final isValid = _isValidPhone(event.phone);
    emit(state.copyWith(
      phone: event.phone,
      isPhoneValid: isValid,
    ));
  }

  /// Handler: Submit forgot password
  Future<void> _onSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      // TODO: Call API forgot password tại đây
      // await authRepository.forgotPassword(state.phone);

      // Giả lập API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: ForgotPasswordStatus.success));
    } catch (error) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: 'Đã xảy ra lỗi: $error',
      ));
    }
  }

  // ==================== Helper Methods ====================

  bool _isValidPhone(String phone) {
    // Validate Vietnamese phone number (10-11 digits)
    return phone.isNotEmpty && phone.length >= 10 && phone.length <= 11;
  }
}

