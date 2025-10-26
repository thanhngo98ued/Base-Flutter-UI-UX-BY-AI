import 'package:base/domain/model/province.dart';
import 'package:base/domain/model/skill.dart';
import 'package:equatable/equatable.dart';

class SignupUiState extends Equatable {
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;
  final String role;
  final bool isPasswordVisible;
  final bool isNameValid;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final Province? selectedProvince;

  final int yearsOfExperience;
  final List<Skill> selectedSkills;
  final String? idCardFrontPath;
  final String? idCardBackPath;
  final bool isYearsOfExperienceValid;
  final String? nameError;
  final String? phoneError;
  final String? passwordError;

  // Master data
  final List<Skill> availableSkills;
  final List<Province> availableProvinces;
  final bool isLoadingMasterData;
  
  // Registration success tracking
  final bool isRegistrationSuccess;

  const SignupUiState({
    this.name = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.role = 'customer',
    this.isPasswordVisible = false,
    this.isNameValid = false,
    this.isPhoneValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.selectedProvince,
    this.yearsOfExperience = 0,
    this.selectedSkills = const [],
    this.idCardFrontPath,
    this.idCardBackPath,
    this.isYearsOfExperienceValid = false,
    this.nameError,
    this.phoneError,
    this.passwordError,
    this.availableSkills = const [],
    this.availableProvinces = const [],
    this.isLoadingMasterData = false,
    this.isRegistrationSuccess = false,
  });

  bool get canSubmit {
    final basicFieldsValid =
        name.trim().isNotEmpty &&
        isPhoneValid &&
        selectedProvince != null &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        isPasswordValid &&
        isConfirmPasswordValid;

    if (role == 'worker') {
      return basicFieldsValid &&
          selectedSkills.isNotEmpty &&
          isYearsOfExperienceValid &&
          yearsOfExperience > 0 &&
          idCardFrontPath != null &&
          idCardBackPath != null;
    }

    return basicFieldsValid;
  }

  SignupUiState copyWith({
    String? name,
    String? phone,
    String? password,
    String? confirmPassword,
    String? role,
    bool? isPasswordVisible,
    bool? isNameValid,
    bool? isPhoneValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    Province? selectedProvince,
    int? yearsOfExperience,
    List<Skill>? selectedSkills,
    String? idCardFrontPath,
    String? idCardBackPath,
    bool? isYearsOfExperienceValid,
    String? nameError,
    String? phoneError,
    String? passwordError,
    List<Skill>? availableSkills,
    List<Province>? availableProvinces,
    bool? isLoadingMasterData,
    bool? isRegistrationSuccess,
    // For explicit null assignments
    bool clearIdCardFrontPath = false,
    bool clearIdCardBackPath = false,
    bool clearSelectedProvince = false,
  }) {
    return SignupUiState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isNameValid: isNameValid ?? this.isNameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      selectedProvince: clearSelectedProvince
          ? null
          : (selectedProvince ?? this.selectedProvince),
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      idCardFrontPath: clearIdCardFrontPath
          ? null
          : (idCardFrontPath ?? this.idCardFrontPath),
      idCardBackPath: clearIdCardBackPath
          ? null
          : (idCardBackPath ?? this.idCardBackPath),
      isYearsOfExperienceValid:
          isYearsOfExperienceValid ?? this.isYearsOfExperienceValid,
      nameError: nameError ?? this.nameError,
      phoneError: phoneError ?? this.phoneError,
      passwordError: passwordError ?? this.passwordError,
      availableSkills: availableSkills ?? this.availableSkills,
      availableProvinces: availableProvinces ?? this.availableProvinces,
      isLoadingMasterData: isLoadingMasterData ?? this.isLoadingMasterData,
      isRegistrationSuccess: isRegistrationSuccess ?? this.isRegistrationSuccess,
    );
  }

  @override
  List<Object?> get props => [
    name,
    phone,
    password,
    confirmPassword,
    role,
    isPasswordVisible,
    isNameValid,
    isPhoneValid,
    isPasswordValid,
    isConfirmPasswordValid,
    selectedProvince,
    yearsOfExperience,
    selectedSkills,
    idCardFrontPath,
    idCardBackPath,
    isYearsOfExperienceValid,
    nameError,
    phoneError,
    passwordError,
    availableSkills,
    availableProvinces,
    isLoadingMasterData,
    isRegistrationSuccess,
  ];

  @override
  bool get stringify => true;
}
