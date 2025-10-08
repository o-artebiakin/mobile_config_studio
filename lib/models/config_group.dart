import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_config_studio/models/config_key.dart';

part 'config_group.freezed.dart';
part 'config_group.g.dart';

@freezed
class ConfigGroup with _$ConfigGroup {
  const factory ConfigGroup({
    required String name,
    @Default([]) List<ConfigKey> keys,
  }) = _ConfigGroup;

  factory ConfigGroup.fromJson(Map<String, dynamic> json) =>
      _$ConfigGroupFromJson(json);
}
