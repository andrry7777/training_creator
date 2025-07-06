// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_out_screen_viewmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkOutScreenState {
  AsyncValue<List<TrainingMenu>> get remainMenu =>
      throw _privateConstructorUsedError;
  List<TrainingMenu> get resultToday => throw _privateConstructorUsedError;
  bool get isResting => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  int get currentRestTime => throw _privateConstructorUsedError;
  bool get isAllMenuCompleted => throw _privateConstructorUsedError;

  /// Create a copy of WorkOutScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkOutScreenStateCopyWith<WorkOutScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkOutScreenStateCopyWith<$Res> {
  factory $WorkOutScreenStateCopyWith(
    WorkOutScreenState value,
    $Res Function(WorkOutScreenState) then,
  ) = _$WorkOutScreenStateCopyWithImpl<$Res, WorkOutScreenState>;
  @useResult
  $Res call({
    AsyncValue<List<TrainingMenu>> remainMenu,
    List<TrainingMenu> resultToday,
    bool isResting,
    int currentIndex,
    int currentRestTime,
    bool isAllMenuCompleted,
  });
}

/// @nodoc
class _$WorkOutScreenStateCopyWithImpl<$Res, $Val extends WorkOutScreenState>
    implements $WorkOutScreenStateCopyWith<$Res> {
  _$WorkOutScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkOutScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainMenu = null,
    Object? resultToday = null,
    Object? isResting = null,
    Object? currentIndex = null,
    Object? currentRestTime = null,
    Object? isAllMenuCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            remainMenu:
                null == remainMenu
                    ? _value.remainMenu
                    : remainMenu // ignore: cast_nullable_to_non_nullable
                        as AsyncValue<List<TrainingMenu>>,
            resultToday:
                null == resultToday
                    ? _value.resultToday
                    : resultToday // ignore: cast_nullable_to_non_nullable
                        as List<TrainingMenu>,
            isResting:
                null == isResting
                    ? _value.isResting
                    : isResting // ignore: cast_nullable_to_non_nullable
                        as bool,
            currentIndex:
                null == currentIndex
                    ? _value.currentIndex
                    : currentIndex // ignore: cast_nullable_to_non_nullable
                        as int,
            currentRestTime:
                null == currentRestTime
                    ? _value.currentRestTime
                    : currentRestTime // ignore: cast_nullable_to_non_nullable
                        as int,
            isAllMenuCompleted:
                null == isAllMenuCompleted
                    ? _value.isAllMenuCompleted
                    : isAllMenuCompleted // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkOutScreenStateImplCopyWith<$Res>
    implements $WorkOutScreenStateCopyWith<$Res> {
  factory _$$WorkOutScreenStateImplCopyWith(
    _$WorkOutScreenStateImpl value,
    $Res Function(_$WorkOutScreenStateImpl) then,
  ) = __$$WorkOutScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AsyncValue<List<TrainingMenu>> remainMenu,
    List<TrainingMenu> resultToday,
    bool isResting,
    int currentIndex,
    int currentRestTime,
    bool isAllMenuCompleted,
  });
}

/// @nodoc
class __$$WorkOutScreenStateImplCopyWithImpl<$Res>
    extends _$WorkOutScreenStateCopyWithImpl<$Res, _$WorkOutScreenStateImpl>
    implements _$$WorkOutScreenStateImplCopyWith<$Res> {
  __$$WorkOutScreenStateImplCopyWithImpl(
    _$WorkOutScreenStateImpl _value,
    $Res Function(_$WorkOutScreenStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkOutScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainMenu = null,
    Object? resultToday = null,
    Object? isResting = null,
    Object? currentIndex = null,
    Object? currentRestTime = null,
    Object? isAllMenuCompleted = null,
  }) {
    return _then(
      _$WorkOutScreenStateImpl(
        remainMenu:
            null == remainMenu
                ? _value.remainMenu
                : remainMenu // ignore: cast_nullable_to_non_nullable
                    as AsyncValue<List<TrainingMenu>>,
        resultToday:
            null == resultToday
                ? _value._resultToday
                : resultToday // ignore: cast_nullable_to_non_nullable
                    as List<TrainingMenu>,
        isResting:
            null == isResting
                ? _value.isResting
                : isResting // ignore: cast_nullable_to_non_nullable
                    as bool,
        currentIndex:
            null == currentIndex
                ? _value.currentIndex
                : currentIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        currentRestTime:
            null == currentRestTime
                ? _value.currentRestTime
                : currentRestTime // ignore: cast_nullable_to_non_nullable
                    as int,
        isAllMenuCompleted:
            null == isAllMenuCompleted
                ? _value.isAllMenuCompleted
                : isAllMenuCompleted // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$WorkOutScreenStateImpl implements _WorkOutScreenState {
  const _$WorkOutScreenStateImpl({
    this.remainMenu = const AsyncValue.data([]),
    final List<TrainingMenu> resultToday = const <TrainingMenu>[],
    this.isResting = false,
    this.currentIndex = 0,
    this.currentRestTime = 0,
    this.isAllMenuCompleted = false,
  }) : _resultToday = resultToday;

  @override
  @JsonKey()
  final AsyncValue<List<TrainingMenu>> remainMenu;
  final List<TrainingMenu> _resultToday;
  @override
  @JsonKey()
  List<TrainingMenu> get resultToday {
    if (_resultToday is EqualUnmodifiableListView) return _resultToday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resultToday);
  }

  @override
  @JsonKey()
  final bool isResting;
  @override
  @JsonKey()
  final int currentIndex;
  @override
  @JsonKey()
  final int currentRestTime;
  @override
  @JsonKey()
  final bool isAllMenuCompleted;

  @override
  String toString() {
    return 'WorkOutScreenState(remainMenu: $remainMenu, resultToday: $resultToday, isResting: $isResting, currentIndex: $currentIndex, currentRestTime: $currentRestTime, isAllMenuCompleted: $isAllMenuCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkOutScreenStateImpl &&
            (identical(other.remainMenu, remainMenu) ||
                other.remainMenu == remainMenu) &&
            const DeepCollectionEquality().equals(
              other._resultToday,
              _resultToday,
            ) &&
            (identical(other.isResting, isResting) ||
                other.isResting == isResting) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.currentRestTime, currentRestTime) ||
                other.currentRestTime == currentRestTime) &&
            (identical(other.isAllMenuCompleted, isAllMenuCompleted) ||
                other.isAllMenuCompleted == isAllMenuCompleted));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    remainMenu,
    const DeepCollectionEquality().hash(_resultToday),
    isResting,
    currentIndex,
    currentRestTime,
    isAllMenuCompleted,
  );

  /// Create a copy of WorkOutScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkOutScreenStateImplCopyWith<_$WorkOutScreenStateImpl> get copyWith =>
      __$$WorkOutScreenStateImplCopyWithImpl<_$WorkOutScreenStateImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkOutScreenState implements WorkOutScreenState {
  const factory _WorkOutScreenState({
    final AsyncValue<List<TrainingMenu>> remainMenu,
    final List<TrainingMenu> resultToday,
    final bool isResting,
    final int currentIndex,
    final int currentRestTime,
    final bool isAllMenuCompleted,
  }) = _$WorkOutScreenStateImpl;

  @override
  AsyncValue<List<TrainingMenu>> get remainMenu;
  @override
  List<TrainingMenu> get resultToday;
  @override
  bool get isResting;
  @override
  int get currentIndex;
  @override
  int get currentRestTime;
  @override
  bool get isAllMenuCompleted;

  /// Create a copy of WorkOutScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkOutScreenStateImplCopyWith<_$WorkOutScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
