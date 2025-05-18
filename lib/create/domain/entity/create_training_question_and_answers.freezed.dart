// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_training_question_and_answers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CreateTrainingQuestionAndAnswers {
  String get question => throw _privateConstructorUsedError;
  List<String> get answers => throw _privateConstructorUsedError;

  /// Create a copy of CreateTrainingQuestionAndAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateTrainingQuestionAndAnswersCopyWith<CreateTrainingQuestionAndAnswers>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTrainingQuestionAndAnswersCopyWith<$Res> {
  factory $CreateTrainingQuestionAndAnswersCopyWith(
    CreateTrainingQuestionAndAnswers value,
    $Res Function(CreateTrainingQuestionAndAnswers) then,
  ) =
      _$CreateTrainingQuestionAndAnswersCopyWithImpl<
        $Res,
        CreateTrainingQuestionAndAnswers
      >;
  @useResult
  $Res call({String question, List<String> answers});
}

/// @nodoc
class _$CreateTrainingQuestionAndAnswersCopyWithImpl<
  $Res,
  $Val extends CreateTrainingQuestionAndAnswers
>
    implements $CreateTrainingQuestionAndAnswersCopyWith<$Res> {
  _$CreateTrainingQuestionAndAnswersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateTrainingQuestionAndAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? question = null, Object? answers = null}) {
    return _then(
      _value.copyWith(
            question:
                null == question
                    ? _value.question
                    : question // ignore: cast_nullable_to_non_nullable
                        as String,
            answers:
                null == answers
                    ? _value.answers
                    : answers // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateTrainingQuestionAndAnswersImplCopyWith<$Res>
    implements $CreateTrainingQuestionAndAnswersCopyWith<$Res> {
  factory _$$CreateTrainingQuestionAndAnswersImplCopyWith(
    _$CreateTrainingQuestionAndAnswersImpl value,
    $Res Function(_$CreateTrainingQuestionAndAnswersImpl) then,
  ) = __$$CreateTrainingQuestionAndAnswersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, List<String> answers});
}

/// @nodoc
class __$$CreateTrainingQuestionAndAnswersImplCopyWithImpl<$Res>
    extends
        _$CreateTrainingQuestionAndAnswersCopyWithImpl<
          $Res,
          _$CreateTrainingQuestionAndAnswersImpl
        >
    implements _$$CreateTrainingQuestionAndAnswersImplCopyWith<$Res> {
  __$$CreateTrainingQuestionAndAnswersImplCopyWithImpl(
    _$CreateTrainingQuestionAndAnswersImpl _value,
    $Res Function(_$CreateTrainingQuestionAndAnswersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateTrainingQuestionAndAnswers
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? question = null, Object? answers = null}) {
    return _then(
      _$CreateTrainingQuestionAndAnswersImpl(
        question:
            null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                    as String,
        answers:
            null == answers
                ? _value._answers
                : answers // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$CreateTrainingQuestionAndAnswersImpl
    implements _CreateTrainingQuestionAndAnswers {
  const _$CreateTrainingQuestionAndAnswersImpl({
    required this.question,
    required final List<String> answers,
  }) : _answers = answers;

  @override
  final String question;
  final List<String> _answers;
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'CreateTrainingQuestionAndAnswers(question: $question, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTrainingQuestionAndAnswersImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    question,
    const DeepCollectionEquality().hash(_answers),
  );

  /// Create a copy of CreateTrainingQuestionAndAnswers
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTrainingQuestionAndAnswersImplCopyWith<
    _$CreateTrainingQuestionAndAnswersImpl
  >
  get copyWith => __$$CreateTrainingQuestionAndAnswersImplCopyWithImpl<
    _$CreateTrainingQuestionAndAnswersImpl
  >(this, _$identity);
}

abstract class _CreateTrainingQuestionAndAnswers
    implements CreateTrainingQuestionAndAnswers {
  const factory _CreateTrainingQuestionAndAnswers({
    required final String question,
    required final List<String> answers,
  }) = _$CreateTrainingQuestionAndAnswersImpl;

  @override
  String get question;
  @override
  List<String> get answers;

  /// Create a copy of CreateTrainingQuestionAndAnswers
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTrainingQuestionAndAnswersImplCopyWith<
    _$CreateTrainingQuestionAndAnswersImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
