import 'package:train_menu_creator/create/domain/entity/create_training_question_and_answers.dart';

const questionsAndAnswers = [
  CreateTrainingQuestionAndAnswers(
    question: '今日トレーニングする部位を教えてください。',
    answers: [],
  ),
  CreateTrainingQuestionAndAnswers(
    question: '今日のトレーニング時間を教えてください。',
    answers: ['1時間', '1時間半', '2時間', '2時間以上'],
  ),
  CreateTrainingQuestionAndAnswers(
    question: '今日のコンディションはどうですか？',
    answers: ['悪い', '普通', '良い'],
  ),
  CreateTrainingQuestionAndAnswers(
    question: '今日のトレーニングはどの強度にしますか',
    answers: ['控えめ', '通常', '高強度'],
  ),
];
