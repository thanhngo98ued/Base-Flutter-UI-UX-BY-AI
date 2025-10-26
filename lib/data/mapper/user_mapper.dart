import 'package:base/data/mapper/base_mapper.dart';
import 'package:base/data/model/user_data.dart';
import 'package:base/domain/model/user_model.dart';

class UserMapper extends BaseMapper<UserData, UserModel> {
  @override
  UserModel map(UserData data) {
    return UserModel(
      userId: data.userId ?? int.tryParse(data.id ?? '0') ?? 0,
      phoneNumber: data.userName ?? data.phoneNumber ?? data.phone ?? '',
      name: data.name,
      role: UserRole.fromValue(data.roleId ?? 0),
      verifyOPT: data.verifyOPT ?? 0,
      accessToken: data.accessToken ?? '',
      refreshToken: data.refreshToken ?? '',
    );
  }
}
