import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.06),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
  }
}
