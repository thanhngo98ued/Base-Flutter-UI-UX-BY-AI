enum UserRole {
  worker(2),
  customer(3);

  const UserRole(this.value);
  final int value;

  static UserRole fromValue(int value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.customer,
    );
  }
}

class UserModel {
  const UserModel({
    required this.userId,
    required this.phoneNumber,
    required this.name,
    required this.role,
    required this.verifyOPT,
    required this.accessToken,
    required this.refreshToken,
  });

  final int userId;
  final String phoneNumber;
  final String name;
  final UserRole role;
  final int verifyOPT;
  final String accessToken;
  final String refreshToken;

  UserModel copyWith({
    int? userId,
    String? phoneNumber,
    String? name,
    UserRole? role,
    int? verifyOPT,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      role: role ?? this.role,
      verifyOPT: verifyOPT ?? this.verifyOPT,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  // User role helpers
  bool get isWorker => role == UserRole.worker;
  bool get isCustomer => role == UserRole.customer;
  
  bool get isVerified => verifyOPT == 1;

  // Serialization
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'phoneNumber': phoneNumber,
    'name': name,
    'role': role.value,
    'verifyOPT': verifyOPT,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['userId'] as int,
    phoneNumber: json['phoneNumber'] as String,
    name: json['name'] as String,
    role: UserRole.fromValue(json['role'] as int),
    verifyOPT: json['verifyOPT'] as int,
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}