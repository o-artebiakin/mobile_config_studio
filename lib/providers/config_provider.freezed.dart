// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConfigState _$ConfigStateFromJson(Map<String, dynamic> json) {
  return _ConfigState.fromJson(json);
}

/// @nodoc
mixin _$ConfigState {
  List<ConfigFlavor> get flavors => throw _privateConstructorUsedError;
  String get selectedFlavorName => throw _privateConstructorUsedError;
  String get selectedGroupName => throw _privateConstructorUsedError;

  /// Serializes this ConfigState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigStateCopyWith<ConfigState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigStateCopyWith<$Res> {
  factory $ConfigStateCopyWith(
    ConfigState value,
    $Res Function(ConfigState) then,
  ) = _$ConfigStateCopyWithImpl<$Res, ConfigState>;
  @useResult
  $Res call({
    List<ConfigFlavor> flavors,
    String selectedFlavorName,
    String selectedGroupName,
  });
}

/// @nodoc
class _$ConfigStateCopyWithImpl<$Res, $Val extends ConfigState>
    implements $ConfigStateCopyWith<$Res> {
  _$ConfigStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flavors = null,
    Object? selectedFlavorName = null,
    Object? selectedGroupName = null,
  }) {
    return _then(
      _value.copyWith(
            flavors: null == flavors
                ? _value.flavors
                : flavors // ignore: cast_nullable_to_non_nullable
                      as List<ConfigFlavor>,
            selectedFlavorName: null == selectedFlavorName
                ? _value.selectedFlavorName
                : selectedFlavorName // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedGroupName: null == selectedGroupName
                ? _value.selectedGroupName
                : selectedGroupName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfigStateImplCopyWith<$Res>
    implements $ConfigStateCopyWith<$Res> {
  factory _$$ConfigStateImplCopyWith(
    _$ConfigStateImpl value,
    $Res Function(_$ConfigStateImpl) then,
  ) = __$$ConfigStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ConfigFlavor> flavors,
    String selectedFlavorName,
    String selectedGroupName,
  });
}

/// @nodoc
class __$$ConfigStateImplCopyWithImpl<$Res>
    extends _$ConfigStateCopyWithImpl<$Res, _$ConfigStateImpl>
    implements _$$ConfigStateImplCopyWith<$Res> {
  __$$ConfigStateImplCopyWithImpl(
    _$ConfigStateImpl _value,
    $Res Function(_$ConfigStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flavors = null,
    Object? selectedFlavorName = null,
    Object? selectedGroupName = null,
  }) {
    return _then(
      _$ConfigStateImpl(
        flavors: null == flavors
            ? _value._flavors
            : flavors // ignore: cast_nullable_to_non_nullable
                  as List<ConfigFlavor>,
        selectedFlavorName: null == selectedFlavorName
            ? _value.selectedFlavorName
            : selectedFlavorName // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedGroupName: null == selectedGroupName
            ? _value.selectedGroupName
            : selectedGroupName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigStateImpl extends _ConfigState with DiagnosticableTreeMixin {
  const _$ConfigStateImpl({
    required final List<ConfigFlavor> flavors,
    required this.selectedFlavorName,
    required this.selectedGroupName,
  }) : _flavors = flavors,
       super._();

  factory _$ConfigStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigStateImplFromJson(json);

  final List<ConfigFlavor> _flavors;
  @override
  List<ConfigFlavor> get flavors {
    if (_flavors is EqualUnmodifiableListView) return _flavors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flavors);
  }

  @override
  final String selectedFlavorName;
  @override
  final String selectedGroupName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConfigState(flavors: $flavors, selectedFlavorName: $selectedFlavorName, selectedGroupName: $selectedGroupName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConfigState'))
      ..add(DiagnosticsProperty('flavors', flavors))
      ..add(DiagnosticsProperty('selectedFlavorName', selectedFlavorName))
      ..add(DiagnosticsProperty('selectedGroupName', selectedGroupName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigStateImpl &&
            const DeepCollectionEquality().equals(other._flavors, _flavors) &&
            (identical(other.selectedFlavorName, selectedFlavorName) ||
                other.selectedFlavorName == selectedFlavorName) &&
            (identical(other.selectedGroupName, selectedGroupName) ||
                other.selectedGroupName == selectedGroupName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_flavors),
    selectedFlavorName,
    selectedGroupName,
  );

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigStateImplCopyWith<_$ConfigStateImpl> get copyWith =>
      __$$ConfigStateImplCopyWithImpl<_$ConfigStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigStateImplToJson(this);
  }
}

abstract class _ConfigState extends ConfigState {
  const factory _ConfigState({
    required final List<ConfigFlavor> flavors,
    required final String selectedFlavorName,
    required final String selectedGroupName,
  }) = _$ConfigStateImpl;
  const _ConfigState._() : super._();

  factory _ConfigState.fromJson(Map<String, dynamic> json) =
      _$ConfigStateImpl.fromJson;

  @override
  List<ConfigFlavor> get flavors;
  @override
  String get selectedFlavorName;
  @override
  String get selectedGroupName;

  /// Create a copy of ConfigState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigStateImplCopyWith<_$ConfigStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
