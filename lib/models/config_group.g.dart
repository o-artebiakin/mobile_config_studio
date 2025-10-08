// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigGroupImpl _$$ConfigGroupImplFromJson(Map<String, dynamic> json) =>
    _$ConfigGroupImpl(
      name: json['name'] as String,
      keys:
          (json['keys'] as List<dynamic>?)
              ?.map((e) => ConfigKey.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ConfigGroupImplToJson(_$ConfigGroupImpl instance) =>
    <String, dynamic>{'name': instance.name, 'keys': instance.keys};
