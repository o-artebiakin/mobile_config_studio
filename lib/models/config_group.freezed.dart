// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConfigGroup _$ConfigGroupFromJson(Map<String, dynamic> json) {
  return _ConfigGroup.fromJson(json);
}

/// @nodoc
mixin _$ConfigGroup {
  String get name => throw _privateConstructorUsedError;
  List<ConfigKey> get keys => throw _privateConstructorUsedError;

  /// Serializes this ConfigGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfigGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigGroupCopyWith<ConfigGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigGroupCopyWith<$Res> {
  factory $ConfigGroupCopyWith(
    ConfigGroup value,
    $Res Function(ConfigGroup) then,
  ) = _$ConfigGroupCopyWithImpl<$Res, ConfigGroup>;
  @useResult
  $Res call({String name, List<ConfigKey> keys});
}

/// @nodoc
class _$ConfigGroupCopyWithImpl<$Res, $Val extends ConfigGroup>
    implements $ConfigGroupCopyWith<$Res> {
  _$ConfigGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? keys = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            keys: null == keys
                ? _value.keys
                : keys // ignore: cast_nullable_to_non_nullable
                      as List<ConfigKey>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfigGroupImplCopyWith<$Res>
    implements $ConfigGroupCopyWith<$Res> {
  factory _$$ConfigGroupImplCopyWith(
    _$ConfigGroupImpl value,
    $Res Function(_$ConfigGroupImpl) then,
  ) = __$$ConfigGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<ConfigKey> keys});
}

/// @nodoc
class __$$ConfigGroupImplCopyWithImpl<$Res>
    extends _$ConfigGroupCopyWithImpl<$Res, _$ConfigGroupImpl>
    implements _$$ConfigGroupImplCopyWith<$Res> {
  __$$ConfigGroupImplCopyWithImpl(
    _$ConfigGroupImpl _value,
    $Res Function(_$ConfigGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfigGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? keys = null}) {
    return _then(
      _$ConfigGroupImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        keys: null == keys
            ? _value._keys
            : keys // ignore: cast_nullable_to_non_nullable
                  as List<ConfigKey>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigGroupImpl implements _ConfigGroup {
  const _$ConfigGroupImpl({
    required this.name,
    final List<ConfigKey> keys = const [],
  }) : _keys = keys;

  factory _$ConfigGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigGroupImplFromJson(json);

  @override
  final String name;
  final List<ConfigKey> _keys;
  @override
  @JsonKey()
  List<ConfigKey> get keys {
    if (_keys is EqualUnmodifiableListView) return _keys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keys);
  }

  @override
  String toString() {
    return 'ConfigGroup(name: $name, keys: $keys)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigGroupImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._keys, _keys));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    const DeepCollectionEquality().hash(_keys),
  );

  /// Create a copy of ConfigGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigGroupImplCopyWith<_$ConfigGroupImpl> get copyWith =>
      __$$ConfigGroupImplCopyWithImpl<_$ConfigGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigGroupImplToJson(this);
  }
}

abstract class _ConfigGroup implements ConfigGroup {
  const factory _ConfigGroup({
    required final String name,
    final List<ConfigKey> keys,
  }) = _$ConfigGroupImpl;

  factory _ConfigGroup.fromJson(Map<String, dynamic> json) =
      _$ConfigGroupImpl.fromJson;

  @override
  String get name;
  @override
  List<ConfigKey> get keys;

  /// Create a copy of ConfigGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigGroupImplCopyWith<_$ConfigGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
