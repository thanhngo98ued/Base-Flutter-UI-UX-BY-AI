import 'dart:convert';

class SizeModel {
  final String? name;
  final int? width;
  final int? height;
  SizeModel({
    this.name,
    this.width,
    this.height,
  });

  SizeModel copyWith({
    String? name,
    int? width,
    int? height,
  }) {
    return SizeModel(
      name: name ?? this.name,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'width': width,
      'height': height,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      name: map['name'] != null ? map['name'] as String : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeModel.fromJson(String source) => SizeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SizeModel(name: $name, width: $width, height: $height)';

  @override
  bool operator ==(covariant SizeModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.width == width && other.height == height;
  }

  @override
  int get hashCode => name.hashCode ^ width.hashCode ^ height.hashCode;
}
