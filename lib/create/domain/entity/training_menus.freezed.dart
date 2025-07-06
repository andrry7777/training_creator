// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_menus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TrainingMenu {
  TrainPart get trainPart => throw _privateConstructorUsedError;
  String get menu => throw _privateConstructorUsedError;
  int get rest => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get advice => throw _privateConstructorUsedError;

  /// Create a copy of TrainingMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingMenuCopyWith<TrainingMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingMenuCopyWith<$Res> {
  factory $TrainingMenuCopyWith(
    TrainingMenu value,
    $Res Function(TrainingMenu) then,
  ) = _$TrainingMenuCopyWithImpl<$Res, TrainingMenu>;
  @useResult
  $Res call({
    TrainPart trainPart,
    String menu,
    int rest,
    int weight,
    int reps,
    String id,
    String advice,
  });
}

/// @nodoc
class _$TrainingMenuCopyWithImpl<$Res, $Val extends TrainingMenu>
    implements $TrainingMenuCopyWith<$Res> {
  _$TrainingMenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainPart = null,
    Object? menu = null,
    Object? rest = null,
    Object? weight = null,
    Object? reps = null,
    Object? id = null,
    Object? advice = null,
  }) {
    return _then(
      _value.copyWith(
            trainPart:
                null == trainPart
                    ? _value.trainPart
                    : trainPart // ignore: cast_nullable_to_non_nullable
                        as TrainPart,
            menu:
                null == menu
                    ? _value.menu
                    : menu // ignore: cast_nullable_to_non_nullable
                        as String,
            rest:
                null == rest
                    ? _value.rest
                    : rest // ignore: cast_nullable_to_non_nullable
                        as int,
            weight:
                null == weight
                    ? _value.weight
                    : weight // ignore: cast_nullable_to_non_nullable
                        as int,
            reps:
                null == reps
                    ? _value.reps
                    : reps // ignore: cast_nullable_to_non_nullable
                        as int,
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            advice:
                null == advice
                    ? _value.advice
                    : advice // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainingMenuImplCopyWith<$Res>
    implements $TrainingMenuCopyWith<$Res> {
  factory _$$TrainingMenuImplCopyWith(
    _$TrainingMenuImpl value,
    $Res Function(_$TrainingMenuImpl) then,
  ) = __$$TrainingMenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TrainPart trainPart,
    String menu,
    int rest,
    int weight,
    int reps,
    String id,
    String advice,
  });
}

/// @nodoc
class __$$TrainingMenuImplCopyWithImpl<$Res>
    extends _$TrainingMenuCopyWithImpl<$Res, _$TrainingMenuImpl>
    implements _$$TrainingMenuImplCopyWith<$Res> {
  __$$TrainingMenuImplCopyWithImpl(
    _$TrainingMenuImpl _value,
    $Res Function(_$TrainingMenuImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainPart = null,
    Object? menu = null,
    Object? rest = null,
    Object? weight = null,
    Object? reps = null,
    Object? id = null,
    Object? advice = null,
  }) {
    return _then(
      _$TrainingMenuImpl(
        trainPart:
            null == trainPart
                ? _value.trainPart
                : trainPart // ignore: cast_nullable_to_non_nullable
                    as TrainPart,
        menu:
            null == menu
                ? _value.menu
                : menu // ignore: cast_nullable_to_non_nullable
                    as String,
        rest:
            null == rest
                ? _value.rest
                : rest // ignore: cast_nullable_to_non_nullable
                    as int,
        weight:
            null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                    as int,
        reps:
            null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                    as int,
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        advice:
            null == advice
                ? _value.advice
                : advice // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$TrainingMenuImpl implements _TrainingMenu {
  _$TrainingMenuImpl({
    required this.trainPart,
    required this.menu,
    required this.rest,
    required this.weight,
    required this.reps,
    this.id = '',
    this.advice = '',
  });

  @override
  final TrainPart trainPart;
  @override
  final String menu;
  @override
  final int rest;
  @override
  final int weight;
  @override
  final int reps;
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String advice;

  @override
  String toString() {
    return 'TrainingMenu(trainPart: $trainPart, menu: $menu, rest: $rest, weight: $weight, reps: $reps, id: $id, advice: $advice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingMenuImpl &&
            (identical(other.trainPart, trainPart) ||
                other.trainPart == trainPart) &&
            (identical(other.menu, menu) || other.menu == menu) &&
            (identical(other.rest, rest) || other.rest == rest) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.advice, advice) || other.advice == advice));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, trainPart, menu, rest, weight, reps, id, advice);

  /// Create a copy of TrainingMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingMenuImplCopyWith<_$TrainingMenuImpl> get copyWith =>
      __$$TrainingMenuImplCopyWithImpl<_$TrainingMenuImpl>(this, _$identity);
}

abstract class _TrainingMenu implements TrainingMenu {
  factory _TrainingMenu({
    required final TrainPart trainPart,
    required final String menu,
    required final int rest,
    required final int weight,
    required final int reps,
    final String id,
    final String advice,
  }) = _$TrainingMenuImpl;

  @override
  TrainPart get trainPart;
  @override
  String get menu;
  @override
  int get rest;
  @override
  int get weight;
  @override
  int get reps;
  @override
  String get id;
  @override
  String get advice;

  /// Create a copy of TrainingMenu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingMenuImplCopyWith<_$TrainingMenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
