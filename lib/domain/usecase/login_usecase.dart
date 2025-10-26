import 'package:base/domain/model/user_model.dart';
import 'package:base/domain/repository/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<UserModel> execute(String phone, String password) async {
    final user = await _authRepository.login(phone, password);

    return user;
  }
}
