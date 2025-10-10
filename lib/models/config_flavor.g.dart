// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_flavor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigFlavorImpl _$$ConfigFlavorImplFromJson(Map<String, dynamic> json) =>
    _$ConfigFlavorImpl(
      name: json['name'] as String,
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map((e) => ConfigGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ConfigFlavorImplToJson(_$ConfigFlavorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groups': instance.groups,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
