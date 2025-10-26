import 'package:base/domain/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<UserModel> login(String phone, String password);
  
  Future<UserModel> register({
    required String name,
    required String phone,
    required int roleId,
    required int provinceId,
    required String password,
    List<int>? skills,
    int? yearExp,
    MultipartFile? passportFront,
    MultipartFile? passportBack,
  });

  Future<bool> verifyOtp(String code, String phone);
  
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
  Future<void> saveUserData(UserModel user);
  Future<void> clearUserData();
}

