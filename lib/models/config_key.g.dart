// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigKeyImpl _$$ConfigKeyImplFromJson(Map<String, dynamic> json) =>
    _$ConfigKeyImpl(
      key: json['key'] as String,
      value: json['value'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ConfigKeyImplToJson(_$ConfigKeyImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
