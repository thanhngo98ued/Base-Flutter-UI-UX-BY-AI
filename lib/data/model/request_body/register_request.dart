import 'package:dio/dio.dart';

class RegisterRequest {
  RegisterRequest({
    required this.name,
    required this.phone,
    required this.roleId,
    required this.provinceId,
    required this.password,
    this.skills,
    this.yearExp,
    this.passportFront,
    this.passportBack,
  });

  final String name;
  final String phone;
  final int roleId;
  final int provinceId;
  final String password;
  final List<int>? skills;
  final int? yearExp;
  final MultipartFile? passportFront;
  final MultipartFile? passportBack;

  FormData toFormData() {
    final formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'roleId': roleId,
      'provinceId': provinceId,
      'password': password,
    });

    if (skills != null && skills!.isNotEmpty) {
      for (var i = 0; i < skills!.length; i++) {
        formData.fields.add(MapEntry('skills[$i]', skills![i].toString()));
      }
    }

    if (yearExp != null) {
      formData.fields.add(MapEntry('yearExp', yearExp.toString()));
    }

    if (passportFront != null) {
      formData.files.add(MapEntry('passportFront', passportFront!));
    }

    if (passportBack != null) {
      formData.files.add(MapEntry('passportBack', passportBack!));
    }

    return formData;
  }

  static Future<MultipartFile> fileFromPath(String path) async {
    final fileName = path.split('/').last;
    return await MultipartFile.fromFile(path, filename: fileName);
  }
}

