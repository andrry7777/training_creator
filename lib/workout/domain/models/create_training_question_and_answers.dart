import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_training_question_and_answers.freezed.dart';

@freezed
class CreateTrainingQuestionAndAnswers with _$CreateTrainingQuestionAndAnswers {
  const factory CreateTrainingQuestionAndAnswers({
    required String question,
    required List<String> answers,
  }) = _CreateTrainingQuestionAndAnswers;
}