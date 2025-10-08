// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigStateImpl _$$ConfigStateImplFromJson(Map<String, dynamic> json) =>
    _$ConfigStateImpl(
      flavors: (json['flavors'] as List<dynamic>)
          .map((e) => ConfigFlavor.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedFlavorName: json['selectedFlavorName'] as String,
      selectedGroupName: json['selectedGroupName'] as String,
      hasUnsavedChanges: json['hasUnsavedChanges'] as bool? ?? false,
    );

Map<String, dynamic> _$$ConfigStateImplToJson(_$ConfigStateImpl instance) =>
    <String, dynamic>{
      'flavors': instance.flavors,
      'selectedFlavorName': instance.selectedFlavorName,
      'selectedGroupName': instance.selectedGroupName,
      'hasUnsavedChanges': instance.hasUnsavedChanges,
    };
