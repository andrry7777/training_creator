import 'package:flutter/material.dart';
import 'package:train_menu_creator/create/domain/entity/training_menus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDetail extends StatelessWidget {
  final TrainingMenu menu;
  final String? gifUrl;

  const MenuDetail(this.menu, {this.gifUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (gifUrl != null && gifUrl!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.network(gifUrl!, height: 150, fit: BoxFit.contain),
          ),
        const SizedBox(height: 8),
        Text(
          menu.menu,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InfoBox(label: '重量', value: '${menu.weight}kg'),
            const SizedBox(width: 16),
            _InfoBox(label: '回数', value: '${menu.reps}回'),
          ],
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          onPressed: () async {
            final url = Uri.parse(
              'https://www.youtube.com/results?search_query=${Uri.encodeComponent('${menu.menu}　フォーム')}',
            );
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          icon: const Icon(Icons.search, color: Colors.deepOrangeAccent),
          label: const Text(
            'フォームを検索',
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
        ),
        _AdviceBanner(advice: menu.advice),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label, value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
          ),
        ),
      ],
    );
  }
}

class _AdviceBanner extends StatelessWidget {
  final String advice;

  const _AdviceBanner({required this.advice});

  @override
  Widget build(BuildContext context) {
    if (advice.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.orangeAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              advice,
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
