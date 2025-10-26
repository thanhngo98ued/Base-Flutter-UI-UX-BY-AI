import 'package:base/domain/model/skill.dart';
import 'package:base/domain/model/province.dart';
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupNameChanged extends SignupEvent {
  final String name;

  const SignupNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class SignupPhoneChanged extends SignupEvent {
  final String phone;

  const SignupPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  const SignupPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class SignupConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;

  const SignupConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class SignupRoleChanged extends SignupEvent {
  final String role;

  const SignupRoleChanged(this.role);

  @override
  List<Object?> get props => [role];
}

class SignupProvinceChanged extends SignupEvent {
  final Province province;

  const SignupProvinceChanged(this.province);

  @override
  List<Object?> get props => [province];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}

class SignupPasswordVisibilityToggled extends SignupEvent {
  const SignupPasswordVisibilityToggled();
}

class SignupYearsOfExperienceChanged extends SignupEvent {
  final int years;

  const SignupYearsOfExperienceChanged(this.years);

  @override
  List<Object?> get props => [years];
}

class SignupSkillToggled extends SignupEvent {
  final Skill skill;

  const SignupSkillToggled(this.skill);

  @override
  List<Object?> get props => [skill];
}

class SignupIdCardFrontUploaded extends SignupEvent {
  final String path;

  const SignupIdCardFrontUploaded(this.path);

  @override
  List<Object?> get props => [path];
}

class SignupIdCardBackUploaded extends SignupEvent {
  final String path;

  const SignupIdCardBackUploaded(this.path);

  @override
  List<Object?> get props => [path];
}

class SignupMasterDataRequested extends SignupEvent {
  const SignupMasterDataRequested();
}

