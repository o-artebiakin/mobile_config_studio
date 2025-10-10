import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/config_group.dart';

part 'config_flavor.freezed.dart';
part 'config_flavor.g.dart';

@freezed
class ConfigFlavor with _$ConfigFlavor {
  const factory ConfigFlavor({
    required String name,
    @Default([]) List<ConfigGroup> groups,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ConfigFlavor;

  const ConfigFlavor._();

  factory ConfigFlavor.fromJson(Map<String, dynamic> json) {
    final placeholderDate = DateTime(0);
    return _$ConfigFlavorFromJson({
      ...json,
      'createdAt': json['createdAt'] ?? placeholderDate.toIso8601String(),
      'updatedAt': json['updatedAt'] ?? placeholderDate.toIso8601String(),
    });
  }
}
