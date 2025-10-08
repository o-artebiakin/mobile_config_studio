import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_key.freezed.dart';
part 'config_key.g.dart';

@freezed
class ConfigKey with _$ConfigKey {
  const factory ConfigKey({
    required String key,
    required String value,
  }) = _ConfigKey;

  factory ConfigKey.fromJson(Map<String, dynamic> json) =>
      _$ConfigKeyFromJson(json);
}
