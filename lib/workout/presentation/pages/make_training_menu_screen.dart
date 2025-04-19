import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:train_menu_creator/workout/domain/constants/make_training_questions_constants.dart';
import 'package:train_menu_creator/workout/domain/enums/train_part_enum.dart';

class QuestionPage extends HookConsumerWidget {
  const QuestionPage({super.key, required this.trainPart});

  final TrainPart trainPart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final pageController = usePageController();

    final answers = <String>[];

    void nextPage(String answer) {
      answers.add(answer);
      if (currentIndex.value < questionsAndAnswers.length - 1) {
        currentIndex.value += 1;
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // 全質問完了時の処理
        debugPrint('全回答: $answers');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔵 上部インジケーター
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: LinearProgressIndicator(
                  color: Colors.orange,
                  minHeight: 10,
                  value: (currentIndex.value + 1) / questionsAndAnswers.length,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questionsAndAnswers.length,
                itemBuilder: (context, index) {
                  final isCurrent = index == currentIndex.value;

                  return AnimatedOpacity(
                    opacity: isCurrent ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            '質問 ${index + 1} / ${questionsAndAnswers.length}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Text(
                                questionsAndAnswers[index].question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: questionsAndAnswers[index].answers.map((e)=> _AnswerButton(text: e, onTap: () => nextPage(e))).toList(),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 4,
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
