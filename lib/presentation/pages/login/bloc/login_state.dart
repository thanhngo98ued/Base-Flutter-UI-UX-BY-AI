import 'package:equatable/equatable.dart';
import 'package:base/domain/model/user_model.dart';

class LoginUiState extends Equatable {
  final String phone;
  final String password;
  final bool isPasswordVisible;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final UserModel? user;

  const LoginUiState({
    this.phone = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isPhoneValid = false,
    this.isPasswordValid = false,
    this.user,
  });

  bool get canSubmit => isPhoneValid && isPasswordValid;

  LoginUiState copyWith({
    String? phone,
    String? password,
    bool? isPasswordVisible,
    bool? isPhoneValid,
    bool? isPasswordValid,
    UserModel? user,
  }) {
    return LoginUiState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    phone,
    password,
    isPasswordVisible,
    isPhoneValid,
    isPasswordValid,
    user,
  ];

  @override
  bool get stringify => true;
}
