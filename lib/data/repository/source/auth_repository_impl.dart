import 'dart:convert';

import 'package:base/data/mapper/user_mapper.dart';
import 'package:base/data/repository/source/local/user_local_data_source.dart';
import 'package:base/data/repository/source/remote/auth_remote_data_source.dart';
import 'package:base/domain/model/user_model.dart';
import 'package:base/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._userLocalDataSource,
    this._userMapper,
  );

  final AuthRemoteDataSource _authRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final UserMapper _userMapper;

  @override
  Future<UserModel> login(String phone, String password) async {
    final response = await _authRemoteDataSource.login(phone, password);

    final user = _userMapper.map(response.data!);
    await saveUserData(user);

    return user;
  }

  @override
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
  }) async {
    final response = await _authRemoteDataSource.register(
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

    final user = _userMapper.map(response.data!);

    return user;
  }

  @override
  Future<bool> verifyOtp(String code, String phone) async {
    final response = await _authRemoteDataSource.verifyOtp(code, phone);
    return response.data?.verified ?? false;
  }

  @override
  Future<void> logout() async {
    await clearUserData();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final prefs = _userLocalDataSource.sharedPreferences;
    final userJsonString = prefs.getString('user_data');

    if (userJsonString == null) {
      return null;
    }

    try {
      final userJson = jsonDecode(userJsonString) as Map<String, dynamic>;
      return UserModel.fromJson(userJson);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    await _userLocalDataSource.saveAccessToken(user.accessToken);
    await _userLocalDataSource.saveRefreshToken(user.refreshToken);

    final prefs = _userLocalDataSource.sharedPreferences;
    final userJson = user.toJson();
    await prefs.setString('user_data', jsonEncode(userJson));
  }

  @override
  Future<void> clearUserData() async {
    await _userLocalDataSource.clearTokens();

    final prefs = _userLocalDataSource.sharedPreferences;
    await prefs.remove('user_data');
  }
}
