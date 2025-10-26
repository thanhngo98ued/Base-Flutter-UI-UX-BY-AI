import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final int provinceId;
  final String name;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final DateTime? deletedAt;

  const Province({
    required this.provinceId,
    required this.name,
    required this.createdAt,
    required this.modifiedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
        provinceId,
        name,
        createdAt,
        modifiedAt,
        deletedAt,
      ];

  @override
  bool get stringify => true;
}
