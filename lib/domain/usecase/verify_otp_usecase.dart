import 'package:base/domain/repository/auth_repository.dart';

class VerifyOtpUseCase {
  VerifyOtpUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<bool> execute(String code, String phone) async {
    final verified = await _authRepository.verifyOtp(code, phone);
    return verified;
  }
}

