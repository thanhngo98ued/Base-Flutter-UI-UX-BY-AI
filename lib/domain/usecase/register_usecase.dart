import 'package:base/domain/model/user_model.dart';
import 'package:base/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class RegisterUseCase {
  RegisterUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<UserModel> execute({
    required String name,
    required String phone,
    required int roleId,
    required int provinceId,
    required String password,
    List<int>? skills,
    int? yearExp,
    String? passportFrontPath,
    String? passportBackPath,
  }) async {
    MultipartFile? passportFront;
    MultipartFile? passportBack;

    if (passportFrontPath != null) {
      passportFront = await MultipartFile.fromFile(
        passportFrontPath,
        filename: passportFrontPath.split('/').last,
      );
    }

    if (passportBackPath != null) {
      passportBack = await MultipartFile.fromFile(
        passportBackPath,
        filename: passportBackPath.split('/').last,
      );
    }

    final user = await _authRepository.register(
      name: name,
      phone: phone,
      roleId: roleId,
      provinceId: provinceId,
      password: password,
      skills: skills,
      yearExp: yearExp,
      passportFront: passportFront,
      passportBack: passportBack,
    );

    return user;
  }
}

