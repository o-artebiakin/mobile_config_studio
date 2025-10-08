// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_flavor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConfigFlavor _$ConfigFlavorFromJson(Map<String, dynamic> json) {
  return _ConfigFlavor.fromJson(json);
}

/// @nodoc
mixin _$ConfigFlavor {
  String get name => throw _privateConstructorUsedError;
  List<ConfigGroup> get groups => throw _privateConstructorUsedError;

  /// Serializes this ConfigFlavor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfigFlavor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigFlavorCopyWith<ConfigFlavor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigFlavorCopyWith<$Res> {
  factory $ConfigFlavorCopyWith(
    ConfigFlavor value,
    $Res Function(ConfigFlavor) then,
  ) = _$ConfigFlavorCopyWithImpl<$Res, ConfigFlavor>;
  @useResult
  $Res call({String name, List<ConfigGroup> groups});
}

/// @nodoc
class _$ConfigFlavorCopyWithImpl<$Res, $Val extends ConfigFlavor>
    implements $ConfigFlavorCopyWith<$Res> {
  _$ConfigFlavorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigFlavor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? groups = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            groups: null == groups
                ? _value.groups
                : groups // ignore: cast_nullable_to_non_nullable
                      as List<ConfigGroup>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfigFlavorImplCopyWith<$Res>
    implements $ConfigFlavorCopyWith<$Res> {
  factory _$$ConfigFlavorImplCopyWith(
    _$ConfigFlavorImpl value,
    $Res Function(_$ConfigFlavorImpl) then,
  ) = __$$ConfigFlavorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<ConfigGroup> groups});
}

/// @nodoc
class __$$ConfigFlavorImplCopyWithImpl<$Res>
    extends _$ConfigFlavorCopyWithImpl<$Res, _$ConfigFlavorImpl>
    implements _$$ConfigFlavorImplCopyWith<$Res> {
  __$$ConfigFlavorImplCopyWithImpl(
    _$ConfigFlavorImpl _value,
    $Res Function(_$ConfigFlavorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfigFlavor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? groups = null}) {
    return _then(
      _$ConfigFlavorImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        groups: null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<ConfigGroup>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigFlavorImpl implements _ConfigFlavor {
  const _$ConfigFlavorImpl({
    required this.name,
    final List<ConfigGroup> groups = const [],
  }) : _groups = groups;

  factory _$ConfigFlavorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigFlavorImplFromJson(json);

  @override
  final String name;
  final List<ConfigGroup> _groups;
  @override
  @JsonKey()
  List<ConfigGroup> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  String toString() {
    return 'ConfigFlavor(name: $name, groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigFlavorImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    const DeepCollectionEquality().hash(_groups),
  );

  /// Create a copy of ConfigFlavor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigFlavorImplCopyWith<_$ConfigFlavorImpl> get copyWith =>
      __$$ConfigFlavorImplCopyWithImpl<_$ConfigFlavorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigFlavorImplToJson(this);
  }
}

abstract class _ConfigFlavor implements ConfigFlavor {
  const factory _ConfigFlavor({
    required final String name,
    final List<ConfigGroup> groups,
  }) = _$ConfigFlavorImpl;

  factory _ConfigFlavor.fromJson(Map<String, dynamic> json) =
      _$ConfigFlavorImpl.fromJson;

  @override
  String get name;
  @override
  List<ConfigGroup> get groups;

  /// Create a copy of ConfigFlavor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigFlavorImplCopyWith<_$ConfigFlavorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
