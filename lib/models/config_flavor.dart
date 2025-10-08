import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobile_config_studio/models/config_group.dart';

part 'config_flavor.freezed.dart';
part 'config_flavor.g.dart';

@freezed
class ConfigFlavor with _$ConfigFlavor {
  const factory ConfigFlavor({
    required String name,
    @Default([]) List<ConfigGroup> groups,
  }) = _ConfigFlavor;

  factory ConfigFlavor.fromJson(Map<String, dynamic> json) =>
      _$ConfigFlavorFromJson(json);
}
