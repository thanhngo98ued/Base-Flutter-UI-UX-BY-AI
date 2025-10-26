import 'package:base/domain/usecase/login_usecase.dart';
import 'package:base/presentation/base/base_bloc.dart';
import 'login_state.dart';

class LoginCubit extends BaseCubit<LoginUiState> {
  LoginCubit(this._loginUseCase) : super(const LoginUiState());

  final LoginUseCase _loginUseCase;

  void onPhoneChanged(String phone) {
    final isValid = _isValidPhone(phone);
    emitUiState(uiState.copyWith(phone: phone, isPhoneValid: isValid));
  }

  void onPasswordChanged(String password) {
    final isValid = password.length >= 6;
    emitUiState(uiState.copyWith(password: password, isPasswordValid: isValid));
  }

  void togglePasswordVisibility() {
    emitUiState(uiState.copyWith(isPasswordVisible: !uiState.isPasswordVisible));
  }

  Future<void> login() async {
    if (!uiState.canSubmit) return;

    await runCatching(
      action: () async {
        final user = await _loginUseCase.execute(uiState.phone, uiState.password);
        emitUiState(uiState.copyWith(user: user));
      },
    );
  }

  bool _isValidPhone(String phone) {
    return phone.isNotEmpty && phone.length >= 10 && phone.length <= 11;
  }
}
