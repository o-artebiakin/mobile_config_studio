import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_config_studio/models/config_key.dart';

part 'config_group.freezed.dart';
part 'config_group.g.dart';

@freezed
class ConfigGroup with _$ConfigGroup {
  const factory ConfigGroup({
    required String name,
    @Default([]) List<ConfigKey> keys,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ConfigGroup;

  factory ConfigGroup.fromJson(Map<String, dynamic> json) {
    final placeholderDate = DateTime(0);
    return _$ConfigGroupFromJson({
      ...json,
      'createdAt': json['createdAt'] ?? placeholderDate.toIso8601String(),
      'updatedAt': json['updatedAt'] ?? placeholderDate.toIso8601String(),
    });
  }
}
