// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'stagger_animation.dart';

class SkillChip extends StatefulWidget {
  final String label;
  final bool interactive;

  const SkillChip({
    super.key,
    required this.label,
    this.interactive = true,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );

    if (!widget.interactive) {
      return child;
    }

    return ScaleOnHover(
      scaleFactor: 1.1,
      duration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}
