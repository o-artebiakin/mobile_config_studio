// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigStateImpl _$$ConfigStateImplFromJson(Map<String, dynamic> json) =>
    _$ConfigStateImpl(
      groups: (json['groups'] as List<dynamic>)
          .map((e) => ConfigGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedGroupName: json['selectedGroupName'] as String,
    );

Map<String, dynamic> _$$ConfigStateImplToJson(_$ConfigStateImpl instance) =>
    <String, dynamic>{
      'groups': instance.groups,
      'selectedGroupName': instance.selectedGroupName,
    };
