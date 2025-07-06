import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Color? cardColor;
  final Color? borderColor;

  const SettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.cardColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor ?? Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
                color: iconColor ?? Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color:
                        titleColor ??
                        Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
              ),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
