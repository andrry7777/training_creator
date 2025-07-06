// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_screen_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeScreenState {
  List<TrainingMenuForHive> get trainingRecords =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeScreenStateCopyWith<HomeScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenStateCopyWith<$Res> {
  factory $HomeScreenStateCopyWith(
    HomeScreenState value,
    $Res Function(HomeScreenState) then,
  ) = _$HomeScreenStateCopyWithImpl<$Res, HomeScreenState>;
  @useResult
  $Res call({List<TrainingMenuForHive> trainingRecords});
}

/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res, $Val extends HomeScreenState>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? trainingRecords = null}) {
    return _then(
      _value.copyWith(
            trainingRecords:
                null == trainingRecords
                    ? _value.trainingRecords
                    : trainingRecords // ignore: cast_nullable_to_non_nullable
                        as List<TrainingMenuForHive>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeScreenStateImplCopyWith<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  factory _$$HomeScreenStateImplCopyWith(
    _$HomeScreenStateImpl value,
    $Res Function(_$HomeScreenStateImpl) then,
  ) = __$$HomeScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TrainingMenuForHive> trainingRecords});
}

/// @nodoc
class __$$HomeScreenStateImplCopyWithImpl<$Res>
    extends _$HomeScreenStateCopyWithImpl<$Res, _$HomeScreenStateImpl>
    implements _$$HomeScreenStateImplCopyWith<$Res> {
  __$$HomeScreenStateImplCopyWithImpl(
    _$HomeScreenStateImpl _value,
    $Res Function(_$HomeScreenStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? trainingRecords = null}) {
    return _then(
      _$HomeScreenStateImpl(
        trainingRecords:
            null == trainingRecords
                ? _value._trainingRecords
                : trainingRecords // ignore: cast_nullable_to_non_nullable
                    as List<TrainingMenuForHive>,
      ),
    );
  }
}

/// @nodoc

class _$HomeScreenStateImpl implements _HomeScreenState {
  const _$HomeScreenStateImpl({
    final List<TrainingMenuForHive> trainingRecords = const [],
  }) : _trainingRecords = trainingRecords;

  final List<TrainingMenuForHive> _trainingRecords;
  @override
  @JsonKey()
  List<TrainingMenuForHive> get trainingRecords {
    if (_trainingRecords is EqualUnmodifiableListView) return _trainingRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trainingRecords);
  }

  @override
  String toString() {
    return 'HomeScreenState(trainingRecords: $trainingRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeScreenStateImpl &&
            const DeepCollectionEquality().equals(
              other._trainingRecords,
              _trainingRecords,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_trainingRecords),
  );

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      __$$HomeScreenStateImplCopyWithImpl<_$HomeScreenStateImpl>(
        this,
        _$identity,
      );
}

abstract class _HomeScreenState implements HomeScreenState {
  const factory _HomeScreenState({
    final List<TrainingMenuForHive> trainingRecords,
  }) = _$HomeScreenStateImpl;

  @override
  List<TrainingMenuForHive> get trainingRecords;

  /// Create a copy of HomeScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
