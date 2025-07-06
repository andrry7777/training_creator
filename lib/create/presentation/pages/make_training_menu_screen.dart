import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/app/router/route_names.dart';
import 'package:train_menu_creator/create/domain/constants/make_training_questions_constants.dart';
import 'package:train_menu_creator/create/domain/entity/create_training_question_and_answers.dart';
import 'package:train_menu_creator/create/domain/enums/train_part_enum.dart';

class QuestionPage extends HookConsumerWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final pageController = usePageController();
    final answers = useState(<String>[]);
    final trainPart = useState(<TrainPart>[]);

    void nextPage([String? answer]) {
      if (currentIndex.value != 0 && answer != null) {
        answers.value.add(answer);
      }

      currentIndex.value += 1;

      if (currentIndex.value >= questionsAndAnswers.length) {
        final extra = {
          'trainPart': trainPart.value,
          'trainTime': answers.value[0],
          'strength': answers.value[1],
          'fatigue': answers.value[2],
        };
        context.go(RouteNames.workout, extra: extra);
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B2730), Color(0xFF0F2A3F)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: LinearProgressIndicator(
                    value:
                        (currentIndex.value + 1) / questionsAndAnswers.length,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade700,
                    valueColor: AlwaysStoppedAnimation(Colors.orange.shade500),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questionsAndAnswers.length,
                  itemBuilder: (context, index) {
                    final qa = questionsAndAnswers[index];
                    final isTrainPartPage = index == 0;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _QuestionContent(
                        key: ValueKey(index),
                        index: index,
                        currentIndex: currentIndex.value,
                        qa: qa,
                        isTrainPartPage: isTrainPartPage,
                        trainPart: trainPart.value,
                        onPartToggle: (part) {
                          trainPart.value =
                              trainPart.value.contains(part)
                                  ? trainPart.value
                                      .where((p) => p != part)
                                      .toList()
                                  : [...trainPart.value, part];
                        },
                        onAnswer: nextPage,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionContent extends StatelessWidget {
  final int index;
  final int currentIndex;
  final CreateTrainingQuestionAndAnswers qa;
  final bool isTrainPartPage;
  final List<TrainPart> trainPart;
  final void Function(String answer) onAnswer;
  final void Function(TrainPart part) onPartToggle;

  const _QuestionContent({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.qa,
    required this.isTrainPartPage,
    required this.trainPart,
    required this.onAnswer,
    required this.onPartToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '質問 ${currentIndex + 1} / ${questionsAndAnswers.length}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B2730), Color(0xFF0F2A3F)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2F36),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  qa.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              isTrainPartPage
                  ? _TrainPartSelector(selected: trainPart, onTap: onPartToggle)
                  : _AnswerList(answers: qa.answers, onTap: onAnswer),
              const SizedBox(height: 24),
              if (isTrainPartPage)
                ElevatedButton(
                  onPressed: trainPart.isNotEmpty ? () => onAnswer('') : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFA8C16),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 4,
                  ),
                  child: const Text('次へ', style: TextStyle(fontSize: 16)),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrainPartSelector extends StatelessWidget {
  final List<TrainPart> selected;
  final void Function(TrainPart part) onTap;

  const _TrainPartSelector({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children:
          TrainPart.values.map((part) {
            final isSelected = selected.contains(part);
            return _SelectableAnswerButton(
              isSelected: isSelected,
              text: part.getStringName,
              onTap: () => onTap(part),
            );
          }).toList(),
    );
  }
}

class _AnswerList extends StatelessWidget {
  final List<String> answers;
  final void Function(String answer) onTap;

  const _AnswerList({required this.answers, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children:
          answers
              .map(
                (answer) =>
                    _AnswerButton(text: answer, onTap: () => onTap(answer)),
              )
              .toList(),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _AnswerButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFFA8C16),
        shadowColor: Colors.black54,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

class _SelectableAnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableAnswerButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:
            isSelected ? const Color(0xFFFA8C16) : Colors.grey.shade700,
        shadowColor: Colors.black54,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
