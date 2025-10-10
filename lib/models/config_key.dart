import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_key.freezed.dart';
part 'config_key.g.dart';

@freezed
class ConfigKey with _$ConfigKey {
  const factory ConfigKey({
    required String key,
    required String value,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ConfigKey;

  const ConfigKey._();

  factory ConfigKey.fromJson(Map<String, dynamic> json) {
    final placeholderDate = DateTime(0);
    return _$ConfigKeyFromJson({
      ...json,
      'createdAt': json['createdAt'] ?? placeholderDate.toIso8601String(),
      'updatedAt': json['updatedAt'] ?? placeholderDate.toIso8601String(),
    });
  }
}
