import 'package:base/data/repository/source/remote/api/error/api_error.dart';
import 'package:base/domain/model/skill.dart';
import 'package:base/domain/usecase/get_provinces_usecase.dart';
import 'package:base/domain/usecase/get_skills_usecase.dart';
import 'package:base/domain/usecase/register_usecase.dart';
import 'package:base/presentation/base/base_bloc.dart';
import 'package:bloc/bloc.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends BaseBloc<SignupEvent, SignupUiState> {
  SignupBloc(
    this._registerUseCase,
    this._getSkillsUseCase,
    this._getProvincesUseCase,
  ) : super(const SignupUiState()) {
    on<SignupNameChanged>(_onNameChanged);
    on<SignupPhoneChanged>(_onPhoneChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignupRoleChanged>(_onRoleChanged);
    on<SignupProvinceChanged>(_onProvinceChanged);
    on<SignupSubmitted>(_onSubmitted);
    on<SignupPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<SignupYearsOfExperienceChanged>(_onYearsOfExperienceChanged);
    on<SignupSkillToggled>(_onSkillToggled);
    on<SignupIdCardFrontUploaded>(_onIdCardFrontUploaded);
    on<SignupIdCardBackUploaded>(_onIdCardBackUploaded);
    on<SignupMasterDataRequested>(_onMasterDataRequested);

    add(const SignupMasterDataRequested());
  }

  final RegisterUseCase _registerUseCase;
  final GetSkillsUseCase _getSkillsUseCase;
  final GetProvincesUseCase _getProvincesUseCase;

  void _onNameChanged(SignupNameChanged event, Emitter emit) {
    final trimmedName = event.name.trim();
    final isValid = trimmedName.isNotEmpty && trimmedName.length >= 2;
    emitUiState(
      uiState.copyWith(name: event.name, isNameValid: isValid, nameError: ''),
    );
  }

  void _onPhoneChanged(SignupPhoneChanged event, Emitter emit) {
    // final isValid = _isValidPhone(event.phone);
    final isValid = event.phone.trim().isNotEmpty;
    emitUiState(
      uiState.copyWith(
        phone: event.phone,
        isPhoneValid: isValid,
        phoneError: '',
      ),
    );
  }

  void _onPasswordChanged(SignupPasswordChanged event, Emitter emit) {
    final isValid = event.password.length >= 6;
    final isConfirmValid =
        uiState.confirmPassword.isEmpty ||
        event.password == uiState.confirmPassword;

    String? passwordError = '';
    if (!isConfirmValid && uiState.confirmPassword.isNotEmpty) {
      passwordError = 'Mật khẩu không khớp với xác nhận mật khẩu';
    }

    emitUiState(
      uiState.copyWith(
        password: event.password,
        isPasswordValid: isValid && isConfirmValid,
        isConfirmPasswordValid: isConfirmValid,
        passwordError: passwordError,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignupConfirmPasswordChanged event,
    Emitter emit,
  ) {
    final isValid = event.confirmPassword == uiState.password;

    String? passwordError = uiState.passwordError;
    if (!isValid &&
        event.confirmPassword.isNotEmpty &&
        uiState.password.isNotEmpty) {
      passwordError = 'Mật khẩu không khớp với xác nhận mật khẩu';
    } else if (isValid &&
        uiState.passwordError == 'Mật khẩu không khớp với xác nhận mật khẩu') {
      passwordError = '';
    }

    emitUiState(
      uiState.copyWith(
        confirmPassword: event.confirmPassword,
        isConfirmPasswordValid: isValid,
        isPasswordValid: uiState.password.length >= 6 && isValid,
        passwordError: passwordError,
      ),
    );
  }

  void _onRoleChanged(SignupRoleChanged event, Emitter emit) {
    if (event.role != 'worker') {
      emitUiState(
        uiState.copyWith(
          role: event.role,
          selectedSkills: const [],
          yearsOfExperience: 0,
          isYearsOfExperienceValid: false,
          clearIdCardFrontPath: true,
          clearIdCardBackPath: true,
        ),
      );
    } else {
      emitUiState(uiState.copyWith(role: event.role));
    }
  }

  void _onProvinceChanged(SignupProvinceChanged event, Emitter emit) {
    emitUiState(uiState.copyWith(selectedProvince: event.province));
  }

  Future<void> _onSubmitted(SignupSubmitted event, Emitter emit) async {
    if (!uiState.canSubmit) return;

    await runCatching(
      action: () async {
        final roleId = uiState.role == 'worker' ? 2 : 3;

        List<int>? skills;
        if (uiState.role == 'worker' && uiState.selectedSkills.isNotEmpty) {
          skills = uiState.selectedSkills
              .map((skill) => skill.skillId)
              .toList();
        }

        await _registerUseCase.execute(
          name: uiState.name,
          phone: uiState.phone,
          roleId: roleId,
          provinceId: uiState.selectedProvince!.provinceId,
          password: uiState.password,
          skills: skills,
          yearExp: uiState.role == 'worker' ? uiState.yearsOfExperience : null,
          passportFrontPath: uiState.idCardFrontPath,
          passportBackPath: uiState.idCardBackPath,
        );
        
        // Emit success state when registration completes
        emitUiState(uiState.copyWith(isRegistrationSuccess: true));
      },
      handleLoading: false,
      handleError: false,
      doOnError: (error) {
        if (error is HttpError && error.statusCode == 422) {
          final nameErrorMsg = error.getFieldError('name');
          final phoneErrorMsg = error.getFieldError('phone');
          final passwordErrorMsg = error.getFieldError('password');

          if (nameErrorMsg != null ||
              phoneErrorMsg != null ||
              passwordErrorMsg != null) {
            emitUiState(
              uiState.copyWith(
                nameError: nameErrorMsg,
                phoneError: phoneErrorMsg,
                passwordError: passwordErrorMsg,
              ),
            );
          } else {
            emitError(error);
          }
        } else {
          emitError(error);
        }
      },
    );
  }

  void _onPasswordVisibilityToggled(
    SignupPasswordVisibilityToggled event,
    Emitter emit,
  ) {
    emitUiState(
      uiState.copyWith(isPasswordVisible: !uiState.isPasswordVisible),
    );
  }

  void _onYearsOfExperienceChanged(
    SignupYearsOfExperienceChanged event,
    Emitter emit,
  ) {
    final isValid = event.years > 0 && event.years <= 50;
    emitUiState(
      uiState.copyWith(
        yearsOfExperience: event.years,
        isYearsOfExperienceValid: isValid,
      ),
    );
  }

  void _onSkillToggled(SignupSkillToggled event, Emitter emit) {
    final skills = List<Skill>.from(uiState.selectedSkills);
    if (skills.any((skill) => skill.skillId == event.skill.skillId)) {
      skills.removeWhere((skill) => skill.skillId == event.skill.skillId);
    } else {
      skills.add(event.skill);
    }
    emitUiState(uiState.copyWith(selectedSkills: skills));
  }

  Future<void> _onMasterDataRequested(
    SignupMasterDataRequested event,
    Emitter emit,
  ) async {
    emitUiState(uiState.copyWith(isLoadingMasterData: true));

    try {
      final skills = await _getSkillsUseCase.execute();
      final provinces = await _getProvincesUseCase.execute();

      emitUiState(
        uiState.copyWith(
          availableSkills: skills,
          availableProvinces: provinces,
          isLoadingMasterData: false,
        ),
      );
    } catch (error) {
      emitUiState(uiState.copyWith(isLoadingMasterData: false));
      emitError(error);
    }
  }

  void _onIdCardFrontUploaded(SignupIdCardFrontUploaded event, Emitter emit) {
    emitUiState(uiState.copyWith(idCardFrontPath: event.path));
  }

  void _onIdCardBackUploaded(SignupIdCardBackUploaded event, Emitter emit) {
    emitUiState(uiState.copyWith(idCardBackPath: event.path));
  }

}
